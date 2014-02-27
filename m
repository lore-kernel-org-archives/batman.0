Return-Path: <michael.holcman1@free.fr>
Date: Thu, 27 Feb 2014 13:20:57 +0100 (CET)
From: michael.holcman1@free.fr
Message-ID: <1770254702.309936059.1393503657979.JavaMail.root@spooler5n-g27.priv.proxad.net>
In-Reply-To: <1375184174.231615127.1391591164796.JavaMail.root@spooler5n-g27.priv.proxad.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Question about batman adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b a t m a n <b.a.t.m.a.n@lists.open-mesh.org>

Hello,
1) I can't creat the 2 files:
 cat /sys/kernel/debug/batman_adv/bat0/log
echo 2 > /sys/class/net/bat0/mesh/log_level

then when i write this line, i have the result:
sudo batctl log
Error - can't open file '/sys/kernel/debug//batman_adv/bat0/log': No such file or directory
To read the debug log you need to compile the module with debugging enabled (see the README)

WWW@ubuntu:~$ sudo batctl ll
Error - can't open file '/sys/class/net/bat0/mesh/log_level': No such file or directory
To increase the log level you need to compile the module with debugging enabled (see the README)

How can i compile it ?

2) The MTU = 1528 is not need to be set on the computer ?

3) How can i lauch batman-adv in debug mode to see all node ?

thank's for your reply,
