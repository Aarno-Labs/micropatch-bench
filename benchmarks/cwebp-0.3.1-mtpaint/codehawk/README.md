- Function of interest is `ReadJPEG`. 
- For binary with md5sum 1295216faf52d66e668b23277ac5cbf9, the function is at address `0xbf08`
- `.bntl` files are type libraries for BinaryNinja for the shared libraries that cwebp depends on. Put them 
in `~/.binaryninja/typelib/armv7/`.
- The default prototype in BinaryNinja for cwebp's `setjmp` function is invalid c99:
```
int32_t _setjmp(jmp_buf& __env)
```
It needs to be changed to for analysis to be possible.
```
int32_t _setjmp(jmp_buf* __env)
```
