(Taken from [Joel's Writings](http://www.joel.lopes-da-silva.com/2010/09/07/compute-md5-or-sha-hash-of-large-file-efficiently-on-ios-and-mac-os-x/), distributed with permission)

# Compute MD5 or SHA hash of large file efficiently on iOS and Mac OS X #

Computing cryptographic hashes of files on iOS and Mac OS X using the CommonCrypto APIs is fairly easy, but doing it in a way that minimizes memory consumption even with large files can be a little more difficult… The other day, I was reading what some people were saying about this on a forum about iPhone development, and they thought they found the trick, but they still had a growing memory footprint with large files because they forgot something fundamental about memory management in Cocoa.

### What was wrong with that solution? ###

Even though they had a solution to read bytes from the file progressively instead of reading everything at once, it did not improve the memory consumption of their program when computing hashes of large files. The mistake they made is that the bytes read in the while loop were in an autoreleased instance of NSData. So, unless they create a local autorelease pool within the while loop, the memory will just accumulate, until the next autorelease pool is drained. But I think it would be very inefficient to add an autorelease pool in the while loop, because you would end up allocating a new object in every pass of the loop.

So, in my opinion, the right question is: how do we read those bytes without getting an autoreleased object?

### How to get around that problem? ###

I looked for a solution, and I couldn’t find anything that would do the same thing as -[NSFileHandle readDataOfLength:] at the Foundation level without returning an autoreleased object. So I thought: we have to go deeper. I looked for something similar in Core Foundation, and sure enough, I found the CFReadStream API.

And since I was going to do this using Core Foundation to read those bytes, I decided to go all the way with Core Foundation, with a solution in pure C.

Here’s how you can compute efficiently the MD5 hash of a large file with CommonCrypto and Core Foundation. Add the FileMD5Hash.h and FileMD5Hash.c to your project and then, from your Objective-C code, add this line at the beginning of your .m file:

    #include "FileMD5Hash.h"
		
And then you can just use that function like this:

    NSString *filePath = ...; // Let's assume filePath is defined...
    CFStringRef md5hash =
        FileMD5HashCreateWithPath((CFStringRef)filePath,
                              FileHashDefaultChunkSizeForReadingData);
    NSLog(@"MD5 hash of file at path \"%@\": %@",
        filePath, (NSString *)md5hash);
    CFRelease(md5hash);

Remember that FileMD5HashCreateWithPath transfers ownership of the returned string, so you must release it yourself.

### Advantages of this solution ###

There are several nice things about this implementation:

* first, it works as advertised: it computes the MD5 hash of the file correctly, and it doesn’t make the memory footprint of your app grow, even if you give it the path to a huge file;
* even though the path argument is a CFStringRef, it’s really easy to use this from Objective-C, thanks to the fact that NSString and CFStringRef are toll-free bridged; cf. example above for usage;
* it works just fine both on iOS and on Mac OS X;
* by reusing sizeof(digest), I avoided the pitfall of exposing the real value of CC\_MD5\_DIGEST\_LENGTH, which would make it more difficult to adapt to other cryptographic algorithms.

### How about SHA1, SHA256, and others? ###

It’s really simple to adapt this function to other algorithms. Say you want to adapt it to get the SHA1 hash instead. Here’s what you need to do:

* replace CC\_MD5\_CTX with CC\_SHA1\_CTX;
* replace CC\_MD5\_Init with CC\_SHA1\_Init;
* replace CC\_MD5\_Update with CC\_SHA1\_Update;
* replace CC\_MD5\_Final with CC\_SHA1\_Final;
* replace CC\_MD5_DIGEST\_LENGTH with CC\_SHA1\_DIGEST\_LENGTH;

Or more simply, just do a find and replace to transform every occurrence of the string "MD5" with "SHA1". Voilà, you got it!

Another way to extend this to other algorithms is to make this function more modular, and basically take all of those things as arguments. This is a little more difficult, but I did it for my project TagAdA. With this [more advanced and more modular solution](http://contribute.tagada.me/browser/branches/mac/Sources/Model/TGDFileHash.c), you have a third argument that represents the algorithm that you wish to use, and you only have one instance of the code associated to that logic in your binary, even if you use several of those cryptographic algorithms in your app. I even went to great lengths using the preprocessor to minimize the amount of duplicated code in my source file. The only drawback I can find of that more advanced solution is that it adds some overhead compared to the one above; sure, there’s one more function call with more arguments, but that’s not a big deal; the main problem is that I had to dynamically allocate the buffers digest and hash, because their size depends on the algorithm used, and the app was crashing if I used those buffers of variable length on the stack. Still, I think it’s completely minor, and I think that implementation is still very efficient.

Anyway, there you go! I hope you will find this useful.