Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416476912.2747.5.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Thu, 20 Nov 2014 10:48:32 +0100
In-Reply-To: <546DA710.2040802@hundeboll.net>
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] kernel BUG at net/core/skbuff.c:100
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi Martin,

Thank you for your response. I'm glad to help making Batman-adv better.

Batman-adv ran with network_coding enabled while kernel panic. This was
a misconfiguration because our nodes doesn't have nc compiled in their
Batman kernel module. The VM is in production. I deactivated nc after
someone told me I do not need nc. But I think my community forgive me
another gateway failure for research sake.

Am Donnerstag, den 20.11.2014, 09:32 +0100 schrieb Martin Hundebøll:
> Thanks for you report. The bug is probably triggered by some bogus data 
> in an incoming packet. I have created a small debug patch that will 
> detect if this is the case, and print some debug info if so.

Thank you for your work. I didn't find your Patch on
http://git.open-mesh.org/batman-adv.git

I can not analyse the packages because the gateway is part of an ISP
infrastructure and there is data privacy. But if you're capable to fish
only the bogus data package during kernel panic with your patch there
shouldn't be any problems, I think.

> Is it possible for you to checkout the source, add the patch, and 
> compile the module?

Yes, I can checkout, patch and compile. The kernel is compiled with
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set

Batman-adv is compiled as module. Is there a reboot of the VM needed if
I patch the source, compile, replace, depmod and reload the Batman
module?

Please send me the patch and tell me the additional make parameters to
compile the module with debug symbols. Is it something like
make \
CONFIG_BATMAN_ADV_DEBUG=y \
CONFIG_BATMAN_ADV_BLA=y \
CONFIG_BATMAN_ADV_DAT=y \
CONFIG_BATMAN_ADV_NC=y
?
If I patch the (batman) kernel sources directly then a simply make in
kernel directory should be enough, I presume. I also presume vmimage
will be updated. Or should I rebuild the kernel from scratch?

I hope, this bug doesn't occur through the gentoo patches. But some
similar freezes happened on Arch Linux with 3.14.23_ARCH and 3.17.1-ARCH
with nc enabled. Unfortunately I can not analyse this bug on the Arch
VMs because I'm not in total control of their VM terminal.

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –

