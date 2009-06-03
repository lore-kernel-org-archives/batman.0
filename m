Message-ID: <4A267954.7060202@gmx.net>
Date: Wed, 03 Jun 2009 15:23:32 +0200
From: elektra <onelektra@gmx.net>
MIME-Version: 1.0
References: <1244030906.4a2667baa4871@cp.tophost.it>
In-Reply-To: <1244030906.4a2667baa4871@cp.tophost.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] batman network test bench
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi Marco!

You could introduce massive traffic from/to as many nodes as possible 
and keep them running for a long time. When I did so with Ubiquiti 
Nanostations I found that the CPU power was too low to saturate the 
network by downloading from /dev/zero from one node to /dev/null on 
another node. (I achieved only ~ 800 kByte/sec on a single hop link - 
rather than 3.3MByte/sec!) I have tried this with netcat, http, ftp, 
iperf. So I connected a laptop to the LAN port of the NS2 and downloaded 
from the laptop via the mesh into another laptop. Which seems to be 
highly impractical in your case.

Bear in mind that depending on the version of your Foneras you are 
rather going to learn about the instability of the hardware or drivers 
in ad-hoc mode. Earlier versions of the Fonera have hardware stability 
issues.

Recent versions of Kamikaze trunk seem to have stability issues in the 
Madwifi driver again - it seems like the stuck beacon problem is back, I 
have seen messages in dmesg that seem to indicate this :-(

Please check the uptime of the nodes during your tests - in case of a 
malfunction the watchdog will silently reboot. Which is what happened to 
me using a DIR-300 every one to three days.

For me I could fix the problem - I'm exclusively using mesh networking 
for all my IT communication needs 24/7 - why would I want to use 
wireless point-to-multipoint networking if I can have 
multipoint-to-multipoint wireless networking ;-)  - by switching to 
ahdemo mode. If you are not using ahdemo, make sure you use ad-hoc mode 
with the nosbeacon aka swmerge option.

That said I prefer testing in a productive environment - of course not 
all users are willing to bear a experimental network as their productive 
environment ;-) But if their connectivity doesn't work in the long run 
you as the admin will quickly get to know about it ;-)

Starting a little community mesh network is a great experiment on all 
kinds of levels, including the social non-OSI Layer 8! And you'll learn 
about technical problems you are never going to meet in your lab - 
because you'll see other drivers/devices in a heterogeneous environment 
trying to connect, introducing noise and trying to create IBSS-ID splits.

 From the protocol side we are keen on getting reports about the 
functionality and usability, CPU load, memory consumption, protocol 
overhead. However a mesh with 6 nodes is not pushing things to the limit 
for the Batman protocol (well, you can decrease the OGM interval to a 
much smaller value than 1 second!). But it will help developers to find 
bugs in recent code changes if you happen to test new versions.

Cheers,
Elektra



> I have 6 fonera stations (openwrt 8.09 + batman)
> I would like to turn them on and check system stability and performance for some
> time
> Can you address me to a good way to test and log system performance/stability?
>
> Thnaks
> Marco
>
> P.S.
> I am available to help batman comunity with specific tests if any.
>   
