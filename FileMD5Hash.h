 /*
 *  FileMD5Hash.h
 *  Compute MD5 hash of large file efficiently on iOS and Mac OS X
 *  http://www.joel.lopes-da-silva.com/2010/09/07/compute-md5-or-sha-hash-of-large-file-efficiently-on-ios-and-mac-os-x/
 * 
 *  Copyright © 2008-2010 Joel Lopes Da Silva. All rights reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 * 
 *        http://www.apache.org/licenses/LICENSE-2.0
 * 
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

// Core Foundation
#include <CoreFoundation/CoreFoundation.h>

// In bytes
#define FileHashDefaultChunkSizeForReadingData 4096

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath, 
                                      size_t chunkSizeForReadingData);