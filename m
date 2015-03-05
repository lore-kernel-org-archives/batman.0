Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 05 Mar 2015 09:05:49 +0100
Message-ID: <4125628.0zdKZFIalx@bentobox>
In-Reply-To: <mct705$mdf$1@ger.gmane.org>
References: <1424719130-2661-1-git-send-email-sven@narfation.org>
 <mct705$mdf$1@ger.gmane.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Drop capabilities when not needed
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: MK <mailing.m1@kkk-web.de>

Hi,

Please Cc me when you want an answer from me (I am not subscribed to this 
mailing list). I just found this mail by pure luck.

On Saturday 28 February 2015 21:04:19 MK wrote:
> Thanks for the patch. Setup seems to be still working. How can I verify that
> privileges really dropped?

The privileges of a process can be found in

$ cat /proc/`pidof alfred`/status

The active capabilities are CapEff. The capabilities the process can request 
can be found in CapPrm.

> There are further questions:
> 
> Is _read_ access for the alfred user (resp. group) sufficient in
> /sys/kernel/debug/batman_adv/* ?
> Or is write access on the socket file in this directory mandatory for full
> functionality?

The process needs to access the path and read the files. For example my system 
allows read of this files by default BUT disallows non-root access to 
/sys/kernel/debug

$ ls -ltrd /sys/kernel/debug
drwx------ 27 root root 0 Mar  2 18:58 /sys/kernel/debug

I would have to allow other users o+rx access to this path before being able 
to access the batman-adv files:

$ cat /sys/kernel/debug/batman_adv/bat0/originators
cat: /sys/kernel/debug/batman_adv/bat0/originators: Permission denied
$ sudo chmod o+rx /sys/kernel/debug
$ cat /sys/kernel/debug/batman_adv/bat0/originators
[B.A.T.M.A.N. adv 2014.3.0, MainIF/MAC: eth0/XX:XX:XX:XX:XX:XX (bat0 
BATMAN_IV)]
  Originator      last-seen (#/255)           Nexthop [outgoingIF]:   
Potential nexthops ...
No batman nodes in range ...


!!!! WARNING !!!!
I don't recommend to grant all users access to /sys/kernel/debug.

Kind regards,
	Sven
