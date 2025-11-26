# Moo Function Color Output Fix Playbook

**tldr;**

**Before**: Pipes output == colors gone. Manual == colors work, script == no colors.

**After**: Send to /dev/tty == colors back. Terminal == pretty, log == plain.

**Quick Check**: Boring output? Pipes == tty thief! /dev/tty == fix.

## Symptoms

- `lolcat` does not show colors or ASCII art in script output.
- Manual commands like `echo "hi" | cowsay | lolcat` work fine.
- Script messages appear as plain text, no fun formatting.
- Log file has plain text, terminal has plain text.

## Causes

- Script pipes stdout via `exec > >(tee log)` for logging.
- `lolcat`/`cowsay` detect piped output (not tty) and skip colors/formatting.
- Manual works because output goes directly to tty.

## Troubleshooting

- Test manual: `echo "test" | lolcat` → should color.
- Check script: Run and see if colors appear in terminal.
- Verify tools: `command -v lolcat` and `command -v cowsay` return paths.
- Inspect pipes: `exec > >(tee log)` redirects stdout, hiding tty.

## Resolutions

- Modify `moo` to output fun to `/dev/tty`, log plain separately.
- Add `> /dev/tty` to `lolcat`/`cowsay` pipes.
- Add `echo "$msg" >> "$log_file"` for logging.
- Keep `exec > >(tee log)` for command outputs.
- Test: Colors in terminal, plain in log.

### Key Code Changes

```bash
# Before: echo "$msg" | lolcat  # Piped, no tty
# After:
echo "$msg" >> "$log_file"  # Log plain
echo "$msg" | lolcat > /dev/tty  # Fun to terminal
```
