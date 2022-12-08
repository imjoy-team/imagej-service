2022-12-08 - Wei and Curtis discussion

## What service functions should the ImageJ service provide?

Possibilities:

1.  A single function, `execute`, that lets you pass a script in any supported SciJava script language.
    - Flexibility: Very powerful. Caller can do whatever they want.
    - Security: Low. Caller can send arbitrary Java programs.
    - Convenience: Medium&mdash;writing a script can be nice, but *needing* to always write a script can be annoying.
    - Integration: Very Low&mdash;all Hypha knows about this service is that it can `execute` things. Not searchable.

2.  Provide functions analogous to what the [ImageJ Server](https://github.com/imagej/imagej-server) does: A) list modules; B) run module by ID; C) upload data; D) download data.
    - Flexibility: Very powerful. Allows execution of any module available from the server's SciJava/ImageJ2 context.
    - Security: Configurable. Caller can only do what the server admin has made available in the SciJava application instance.
    - Convenience: Very Low&mdash;workflows must be composed by multiple remote function calls, by module ID. Can be tedious to assemble.
    - Integration: Low&mdash;all Hypha knows about this service is that it can `list`, `run`, `upload`, `download`. Still not searchable.

3.  Provide one Hypha API function per available SciJava module.
    - Flexibility: Very powerful. Allows execution of any module available from the server's SciJava/ImageJ2 context.
    - Security: Configurable. Caller can only do what the server admin has made available in the SciJava application instance.
    - Convenience: Low&mdash;workflows must be composed by multiple remote function calls. Can be tedious to assemble. But now, at least each SciJava module is a native Hypha functions, making them simpler to discover and introspect.
    - Integration: High&mdash;Hypha understands the inputs and outputs of each SciJava module, since they are mapped to its own mechanism. Users can search for functions. And it allows users to compose a workflow with other Ops frameworks within hypha app engine, see [workflows-bioimage-io-python](https://github.com/bioimage-io/workflows-bioimage-io-python).

## How to share (or not) SciJava application instances between users, processes, containers?

Notes:
- Each Python process can start only one JVM as a subprocess.
- Each JVM can create multiple simultaneous instances of ImageJ2&mdash;but only *one* legacy-enabled ImageJ2 at a time per JVM right now. (It might be possible to overcome this limitation, but would require work in the ImageJ Legacy project to be smarter about custom `ClassLoader`s.)

Options:

1. One user = isolated Docker container with its own Python process with isolated JVM with isolated SciJava application context. Security high, overhead high.

2. All users share one Docker container, but each has its own Python process with isolated JVM with isolated SciJava application context. Could potentially leak data between users due to shared file system (but not shared JVM).

3. All users share one Docker container, one Python process, one JVM, but separate SciJava application contexts. Unfortunately, right now, only one of them can support the original ImageJ functions via the ImageJ Legacy Bridge, unless we do development work on the Java side. And still possible to leak data between users because JVM and file system are shared.

4. All users share one Docker container, one Python process, one JVM, one single SciJava application context with original ImageJ support. Least secure, but lowest overhead. Possible to leak data between users.
