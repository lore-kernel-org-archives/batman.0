Return-Path: <bug-track@fisher-privat.net>
Message-ID: <4EC0EF83.2060602@fisher-privat.net>
Date: Mon, 14 Nov 2011 11:37:55 +0100
From: Alexey Fisher <bug-track@fisher-privat.net>
MIME-Version: 1.0
References: <1321261892-6401-1-git-send-email-bug-track@fisher-privat.net>
	<9935980.KTPM4GpO8u@sven-laptop.home.narfation.org>
	<4EC0EB27.8060207@fisher-privat.net>
	<1956205.mQFSXpQuIf@sven-laptop.home.narfation.org>
In-Reply-To: <1956205.mQFSXpQuIf@sven-laptop.home.narfation.org>
Content-Type: multipart/mixed; boundary="------------090405090803010609000309"
Subject: Re: [B.A.T.M.A.N.] [PATCH] add make install
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, lindner_marek@yahoo.de

This is a multi-part message in MIME format.
--------------090405090803010609000309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.11.2011 11:29, Sven Eckelmann wrote:
> On Monday 14 November 2011 11:19:19 Alexey Fisher wrote:
> [...]
>> Thank you,
>> so you will send your patch? I prefer last version, to make testing easier.
> 
> I personally don't care. Feel free to fix your patch and send a new version 
> (but think about adding the ":" after "install" -- the character magically 
> disappeared when I wrote the mail).
> 
> And don't forget the documentation part as it is always hard to remember 
> everything on the day the release is made, but easy when you just made the 
> patch. :)

Corrected.

--------------090405090803010609000309
Content-Type: text/x-patch;
 name="0001-add-make-install-option.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-add-make-install-option.patch"

From 04e5cfa522d79a2a8764ee7ce04f8d0842ee37be Mon Sep 17 00:00:00 2001
From: Alexey Fisher <bug-track@fisher-privat.net>
Date: Mon, 14 Nov 2011 11:35:13 +0100
Subject: [PATCH] add "make install" option

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>
---
 Makefile |    3 +++
 README   |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5762721..3374687 100644
--- a/Makefile
+++ b/Makefile
@@ -42,3 +42,6 @@ all:
 
 clean:
 	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) clean
+
+install:
+	$(MAKE) -C $(KERNELPATH) M=$(PWD) PWD=$(PWD) INSTALL_MOD_DIR=kernel/net/batman-adv/ modules_install
diff --git a/README b/README
index 5ba56b5..ec85dff 100644
--- a/README
+++ b/README
@@ -34,6 +34,10 @@ if you want to compile against some other kernel, use:
 
 # make KERNELPATH=/path/to/kernel
 
+if you wont to install this module:
+
+# sudo make install
+
 
 CONFIGURATION
 -------------
-- 
1.7.5.4


--------------090405090803010609000309--
