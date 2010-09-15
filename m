Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 16 Sep 2010 00:30:35 +0200
Message-Id: <1284589835-26617-1-git-send-email-sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH] batman-ad: automatically add .llseek fop
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

From: Arnd Bergmann <arnd@arndb.de>

All file_operations should get a .llseek
operation so we can make nonseekable_open
the default for future file operations
without a .llseek pointer.

The three cases that we can automatically
detect are no_llseek, seq_lseek and
default_llseek. For cases where we can
we can automatically prove that the
file offset is always ignored, we use
noop_llseek, which maintains the current
behavior of not returning an error from
a seek.

New drivers should normally not use
noop_llseek but instead use no_llseek and
call nonseekable_open at open time.
Existing drivers can be converted to do
the same when the maintainer knows for
certain that no user code relies on calling
seek on the device file.

The generated code is often incorrectly
indented and right now contains comments that
clarify for each added line why a specific
variant was chosen. In the version that gets
submitted upstream, the comments will be gone
and I will manually fix the indentation,
because there does not seem to be a way to
do that using coccinelle.

Some amount of new code is currently sitting
in linux-next that should get the same
modifications, which I will do at the end of
the merge window.

Many thanks to Julia Lawall for helping me
learn to write a semantic patch that does
all this.

===== begin semantic patch =====
// This adds an llseek= method to all file operations,
// as a preparation for making no_llseek the default.
//
// The rules are
// - use no_llseek explicitly if we do nonseekable_open
// - use seq_lseek for sequential files
// - use default_llseek if we know we access f_pos
// - use noop_llseek if we know we don't access f_pos,
//   but we still want to allow users to call lseek
//
@ open1 exists @
identifier nested_open;
@@
nested_open(...)
{
<+...
nonseekable_open(...)
...+>
}

@ open exists@
identifier open_f;
identifier i, f;
identifier open1.nested_open;
@@
int open_f(struct inode *i, struct file *f)
{
<+...
(
nonseekable_open(...)
|
nested_open(...)
)
...+>
}

@ read disable optional_qualifier exists @
identifier read_f;
identifier f, p, s, off;
type ssize_t, size_t, loff_t;
expression E;
identifier func;
@@
ssize_t read_f(struct file *f, char *p, size_t s, loff_t *off)
{
<+...
(
   *off = E
|
   *off += E
|
   func(..., off, ...)
|
   E = *off
)
...+>
}

@ read_no_fpos disable optional_qualifier exists @
identifier read_f;
identifier f, p, s, off;
type ssize_t, size_t, loff_t;
@@
ssize_t read_f(struct file *f, char *p, size_t s, loff_t *off)
{
... when != off
}

@ write @
identifier write_f;
identifier f, p, s, off;
type ssize_t, size_t, loff_t;
expression E;
identifier func;
@@
ssize_t write_f(struct file *f, const char *p, size_t s, loff_t *off)
{
<+...
(
  *off = E
|
  *off += E
|
  func(..., off, ...)
|
  E = *off
)
...+>
}

@ write_no_fpos @
identifier write_f;
identifier f, p, s, off;
type ssize_t, size_t, loff_t;
@@
ssize_t write_f(struct file *f, const char *p, size_t s, loff_t *off)
{
... when != off
}

@ fops0 @
identifier fops;
@@
struct file_operations fops = {
 ...
};

@ has_llseek depends on fops0 @
identifier fops0.fops;
identifier llseek_f;
@@
struct file_operations fops = {
...
 .llseek = llseek_f,
...
};

@ has_read depends on fops0 @
identifier fops0.fops;
identifier read_f;
@@
struct file_operations fops = {
...
 .read = read_f,
...
};

@ has_write depends on fops0 @
identifier fops0.fops;
identifier write_f;
@@
struct file_operations fops = {
...
 .write = write_f,
...
};

@ has_open depends on fops0 @
identifier fops0.fops;
identifier open_f;
@@
struct file_operations fops = {
...
 .open = open_f,
...
};

// use no_llseek if we call nonseekable_open
////////////////////////////////////////////
@ nonseekable1 depends on !has_llseek && has_open @
identifier fops0.fops;
identifier nso ~= "nonseekable_open";
@@
struct file_operations fops = {
...  .open = nso, ...
+.llseek = no_llseek, /* nonseekable */
};

@ nonseekable2 depends on !has_llseek @
identifier fops0.fops;
identifier open.open_f;
@@
struct file_operations fops = {
...  .open = open_f, ...
+.llseek = no_llseek, /* open uses nonseekable */
};

// use seq_lseek for sequential files
/////////////////////////////////////
@ seq depends on !has_llseek @
identifier fops0.fops;
identifier sr ~= "seq_read";
@@
struct file_operations fops = {
...  .read = sr, ...
+.llseek = seq_lseek, /* we have seq_read */
};

// use default_llseek if there is a readdir
///////////////////////////////////////////
@ fops1 depends on !has_llseek && !nonseekable1 && !nonseekable2 && !seq @
identifier fops0.fops;
identifier readdir_e;
@@
// any other fop is used that changes pos
struct file_operations fops = {
... .readdir = readdir_e, ...
+.llseek = default_llseek, /* readdir is present */
};

// use default_llseek if at least one of read/write touches f_pos
/////////////////////////////////////////////////////////////////
@ fops2 depends on !fops1 && !has_llseek && !nonseekable1 && !nonseekable2 && !seq @
identifier fops0.fops;
identifier read.read_f;
@@
// read fops use offset
struct file_operations fops = {
... .read = read_f, ...
+.llseek = default_llseek, /* read accesses f_pos */
};

@ fops3 depends on !fops1 && !fops2 && !has_llseek && !nonseekable1 && !nonseekable2 && !seq @
identifier fops0.fops;
identifier write.write_f;
@@
// write fops use offset
struct file_operations fops = {
... .write = write_f, ...
+	.llseek = default_llseek, /* write accesses f_pos */
};

// Use noop_llseek if neither read nor write accesses f_pos
///////////////////////////////////////////////////////////

@ fops4 depends on !fops1 && !fops2 && !fops3 && !has_llseek && !nonseekable1 && !nonseekable2 && !seq @
identifier fops0.fops;
identifier read_no_fpos.read_f;
identifier write_no_fpos.write_f;
@@
// write fops use offset
struct file_operations fops = {
...
 .write = write_f,
 .read = read_f,
...
+.llseek = noop_llseek, /* read and write both use no f_pos */
};

@ depends on has_write && !has_read && !fops1 && !fops2 && !has_llseek && !nonseekable1 && !nonseekable2 && !seq @
identifier fops0.fops;
identifier write_no_fpos.write_f;
@@
struct file_operations fops = {
... .write = write_f, ...
+.llseek = noop_llseek, /* write uses no f_pos */
};

@ depends on has_read && !has_write && !fops1 && !fops2 && !has_llseek && !nonseekable1 && !nonseekable2 && !seq @
identifier fops0.fops;
identifier read_no_fpos.read_f;
@@
struct file_operations fops = {
... .read = read_f, ...
+.llseek = noop_llseek, /* read uses no f_pos */
};

@ depends on !has_read && !has_write && !fops1 && !fops2 && !has_llseek && !nonseekable1 && !nonseekable2 && !seq @
identifier fops0.fops;
@@
struct file_operations fops = {
...
+.llseek = noop_llseek, /* no read or write fn */
};
===== End semantic patch =====

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Julia Lawall <julia@diku.dk>
Cc: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
---
 batman-adv/bat_debugfs.c |    1 +
 batman-adv/icmp_socket.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/batman-adv/bat_debugfs.c b/batman-adv/bat_debugfs.c
index c73ce4a..0b35616 100644
--- a/batman-adv/bat_debugfs.c
+++ b/batman-adv/bat_debugfs.c
@@ -177,6 +177,7 @@ static const struct file_operations log_fops = {
 	.release        = log_release,
 	.read           = log_read,
 	.poll           = log_poll,
+	.llseek = noop_llseek,/* read uses no f_pos */
 };
 
 static int debug_log_setup(struct bat_priv *bat_priv)
diff --git a/batman-adv/icmp_socket.c b/batman-adv/icmp_socket.c
index 85c047b..bc5e25a 100644
--- a/batman-adv/icmp_socket.c
+++ b/batman-adv/icmp_socket.c
@@ -285,6 +285,7 @@ static const struct file_operations fops = {
 	.read = bat_socket_read,
 	.write = bat_socket_write,
 	.poll = bat_socket_poll,
+	.llseek = noop_llseek,/* read and write both use no f_pos */
 };
 
 int bat_socket_setup(struct bat_priv *bat_priv)
-- 
1.7.2.3

