# Mr. Game and Watch
## Reversing
* loaded the file into ghidra and decompiled it
* found the three functions responsible for holding each secret, crack_1, crack_2, and crack_3
* worked backwards to come up with the inputs that would satisfy these functions
* sent the passwords to the server which provided the flag

# Salty
## Password Cracking
* it was a salted md5 hash
* used hashcat with a wordlist (crackstation, but rockyou was probably sufficient) in salted md5 mode
* there are two modes for salted md5 in hashcat, pass.salt and salt.pass, it was the second.
I had to try both modes to crack it

# Zippy
## Password Cracking
* found out it was a series of encrypted zips nested inside each other
* wrote a script (included) that used hashcat to continuously crack zip passwords and extract the zip
* let the script run, it took about 5 minutes per zip to crack the password, and there were quite a few zips

# Mental
## Password Cracking
* Saw what the password pattern was from the prompt and made 3 wordlists as a result (included)
* made the wordlists just by googling "list of all fruit", "list of all countries", "list of all colors"
* used a bash script (included) to combine the three lists into one "master wordlist" that included all combinations of the lists
* used hashcat with that wordlist to crack the password

# Manager
## Password Cracking
* noticed it was a keepass archive
* extracted hash from keepass (after googling how to do that)
* set hashcat to keepass mode with the wordlists I had

# Big Mac
## Password Cracking
* guessed from the challenge name that it was SHA1-HMAC
* set hashcat to sha1-hmac and it was in the dictionary

# Pick Up That CAN
## Signals
* googled how to replay CAN dumps
* found out that VW added CAN support to the linux kernel
* used the provided shell script to create a virtual CAN interface on my computer
* used `cansniffer` to replay the can data as I was playing it back to the vcan0 interface using `canplayer`
* flag was in the replay data

# Digital
## Signals
* used `ffprobe` to determine how the audio was transmitted (BPSK63 in this case) and the transmission frequency
* used fldigi to replay it and it printed the flag

# You Can Tell From Some of The Pixels
## Signals
* used `ffprobe` to figure out how to set up fldigi, like the previous challenge
* replayed the data
* the data was a series of base64 dumps
* concatenated all the base64 data in python (included) and wrote it to a file, it was an image with the flag

# 5 Layer Dip
## Signals
* started with `ffprobe`, changed fldigi accordingly
* saw that it was a series of hex dumps
* tried to identify what kind of data it was, initially by concatenating all data into a single long hex
file, then reverse hex dumping it with `xxd -r -p`
* I ran `file` on the result and it told me it was a word document, but `binwalk` gave me zip files
which I tried to extract, but they did not work properly
* I then ran `strings -a` against the binary and saw that it was an FTP session, where someone downloads a docx file
* then I googled how to import a hex dump into wireshark, and proceeded to fix the hex that came out of fldigi until
there were no partial packets (there were random r0's interspersed that I manually fixed with vim by turning them into newlines)
* then I looked up how to extract files from FTP sessions in wireshark, used "Follow TCP Stream" and extracted the docx
which had the flag in it

# Oops
## Forensics
* looked up how to mount vhdx files
* downloaded libguestfs and used guestfish to extract the files in the archive to my computer
* then after searching the files for a bit I found the flag hidden in the initrd.gz file, using `zcat | less` to inspect it

# Fahrenheit 451
## Forensics
* extracted PDF from pcap using wireshark
* used `pdfinfo` to see if there was anything in the metadata
* used `pdftotext` to convert the PDF to a plain text document
* found the strange cipher string
* since I knew the first few characters of the flag were `auctf{` and the last character was `}` I could line up the
alphabets and it did confirm that it was a simple substitution cipher, as Loic had pointed out, since the in the prompt
SUBSTITUTE was capitalized
* figured out that it was an ASCII substitution cipher, specifically rot47
* translated the cipher text, it was the flag
