Return-Path: <spyrosgaster@gmail.com>
MIME-Version: 1.0
Sender: spyrosgaster@gmail.com
From: NorthPole <morfeas3000@gmail.com>
Date: Sun, 27 May 2012 17:00:42 +0300
Message-ID: <CA+wR77oJFdK9RZN+zoJ0wL30bv-K=ifwU2tLbFUaNKNecx2YaA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Questions regarding the Emulation envirnment setup
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hello everyone, i'm trying to setup an emulation environment and i
have some questions:

* although i downloaded the vde2-2.3.1 source and the appropriate
patches (vde2-2.3.1_colour.patch and
vde2-2.3.1-wirefilter-ethertype.patch ) the wirefilter patch could not
be applied giving the following output

 $patch <vde2-2.3.1-wirefilter-ethertype.patch
patching file wirefilter.c
Hunk #1 FAILED at 59.
Hunk #2 FAILED at 524.
Hunk #3 FAILED at 1391.
Hunk #4 FAILED at 1402.
Hunk #5 FAILED at 1421.
Hunk #6 FAILED at 1475.
6 out of 6 hunks FAILED -- saving rejects to file wirefilter.c.rej

any tips on how I can find why it failed and how to apply the patch?


*I ran the script without the wirefilter patch and I got a blank
terminal,is this expected?

* how can I get the dmesg(and generally any command) output
from the qemu instances?


*provided i have built open-wrt with batman and have put the
appropriate script in wrt's  ./files/etc/rc.local batman should start
as a daemon right?
given that, I should be seeing batman packets in the capture, right?

*wireshark should recognize that a given packet is an ogm packet or
there is another way to filter only the relevant ones?


Thank you for your time
