# demo-parallel-tasks

Example used to demonstrate running tasks in parallel.

Image is in public domain and taken from https://en.wikipedia.org/wiki/Automation.

Links created with:

```bash
for number in $(seq -f %02g 2 10); do
    ln -s 01.jpg ${number}.jpg
done
```
