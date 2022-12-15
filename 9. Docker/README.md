# 9. Docker

The style guidelines and best practices for our engineering team.

# **1. INSTALL DOCKER ENGINE**

---

- **2 spaces** – for indentation
- **No unused variables** – this one catches tons of bugs!
- **No semicolons** – It's fine. Really!
- Never start a line with `(` , `[` , or `````
    - This is the only gotcha with omitting semicolons – automatically checked for you!
- **Space after keywords** `if (condition) { ... }`
- Always use `===` instead of `==` – but `obj == null` is allowed to check `null || undefined` .

---

The easiest way to use JavaScript Standard Style to check your code is to install it globally as a Node command line program. To do so, simply run the following command in your terminal (flag `-g` installs standard globally on your system, omit it if you want to install in the current working directory):

```bash
npm install standard -g
```

After you've done that you should be able to use the `standard` program. The simplest use case would be checking the style of all JavaScript files in the current working directory:

```bash
$ standard
Error: Use JavaScript Standard Style
 lib/torrent.js:950:11: Expected '===' and instead saw '=='.
```

This guide is based on [https://github.com/feross/standard](https://github.com/feross/standard)

# 2**. xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx**

---

- **2 spaces** – for indentation
- **No unused variables** – this one catches tons of bugs!
- **No semicolons** – It's fine. Really!
- Never start a line with `(` , `[` , or `````
    - This is the only gotcha with omitting semicolons – automatically checked for you!
- **Space after keywords** `if (condition) { ... }`
- Always use `===` instead of `==` – but `obj == null` is allowed to check `null || undefined` .

---

The easiest way to use JavaScript Standard Style to check your code is to install it globally as a Node command line program. To do so, simply run the following command in your terminal (flag `-g` installs standard globally on your system, omit it if you want to install in the current working directory):

```bash
npm install standard -g
```

After you've done that you should be able to use the `standard` program. The simplest use case would be checking the style of all JavaScript files in the current working directory:

```bash
$ standard
Error: Use JavaScript Standard Style
 lib/torrent.js:950:11: Expected '===' and instead saw '=='.
```
