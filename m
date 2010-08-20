Return-Path: <djb31st@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTimRzmDuNR21UOuHHRt7tEvAoKjULVigpfkR2M0C@mail.gmail.com>
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<201008141646.49517.lindner_marek@yahoo.de>
	<AANLkTimpmFOrT_AnH5Fq-50uLBJswhC_T1-B3G4fC8Nc@mail.gmail.com>
	<201008161832.14980.sven.eckelmann@gmx.de>
	<AANLkTimRzmDuNR21UOuHHRt7tEvAoKjULVigpfkR2M0C@mail.gmail.com>
Date: Fri, 20 Aug 2010 12:57:50 +0300
Message-ID: <AANLkTim9xwEgYLwK0bOzzmKkLMK6aedMDvD+SjrnTXFe@mail.gmail.com>
From: David Beaumont <djb31st@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Nat Question
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

Sorry previous message got cut off...

I've been busy trying to track down these ping issues and it appears
to be a problem with the actual ping program supplied with open rather
than a network problem.

I know get the following results from the mesh router

Generic:~# /usr/bin/ping -M do -s 1472 google.com
PING google.com (74.125.39.105) 1472(1500) bytes of data.
72 bytes from fx-in-f105.1e100.net (74.125.39.105): icmp_seq=3D1 ttl=3D53
(truncated)
72 bytes from fx-in-f105.1e100.net (74.125.39.105): icmp_seq=3D2 ttl=3D53
(truncated)

Generic:~# /usr/bin/ping -M do -s 1473 google.com
PING google.com (74.125.39.99) 1473(1501) bytes of data.
From 192.168.1.123 icmp_seq=3D1 Frag needed and DF set (mtu =3D 1500)
From 192.168.1.123 icmp_seq=3D1 Frag needed and DF set (mtu =3D 1500)

So large pings appear to be going over the batman interface.

However still not getting any web traffic through

root@Generic:~# echo "HEAD / HTTP/1.1\nHost: git.open-mesh.net\n\n"|nc
git.open-mesh.net 80

root@Generic:~# wget http://www.google.com
Connecting to www.google.com (74.125.39.104:80)

What else can i provide to help track down the problem here :-(

Dave

On Tue, Aug 17, 2010 at 11:14 AM, David Beaumont <djb31st@gmail.com> wrote:
> The plot thickens..
>
> i started producing the tcp dumps that you requested to take a look at
> and noticed the following.
>
> On the main internet node, if i ping google.com everything is fine.
> However if i ping -s 1464 google.com i do not get a reply, this isn't
> even going over the batman interface. So it looks like i have more of
> a local problem.
>
> To clarify
>
> ping -s 1464 google.com
>
> results in ping requests being sent and recieved on ETH1, but not
> being returned to br-lan
>
> ping google.com
>
> results in ping requests being sent and recieved on ETH1, and being
> returned on br-lan
>
> ping -s 84 google.com will work
> ping -s 85 google.com will not work.
>
> I've never encountered these issues before, but i think they are the
> route cause of my problem? As was initially stated an MTU issue, i
> just need to find where!
>
> echo "HEAD / HTTP/1.1\nHost: git.open-mesh.net\n\n"|nc git.open-mesh.net =
80
>
> from the mesh node brings no results, although works as expected on
> the internet node.
>
>
>
>
>
>
>
>
>
> On Mon, Aug 16, 2010 at 7:32 PM, Sven Eckelmann <sven.eckelmann@gmx.de> w=
rote:
>> David Beaumont wrote:
>>> Sorry for the late reply, a few things came up over the weekend that i
>>> had to attend to.
>>>
>>> Here are three tcp dump files from the internet node on bat0 and one
>>> on eth1 (the internet port)
>>>
>>> Really don't understand what is wrong here :-(
>>
>> Ok, test plan:
>>
>> =A0* Find the machine and interface were a response from google.com coul=
d be
>> =A0 received but which will not forward it to the other interface
>> =A0* take a real dump on all interfaces (wan and lan)
>> =A0 tcpdump -s 0 -i eth1 -w eth1.dump
>> =A0* when the response packet is forwarded over the lan/bat0 interface b=
ut
>> =A0 doesn't get to the final machine than please also create a tcpdump o=
n the
>> =A0 receiving machine (real interface and maybe bat0)
>> =A0* Go to your router and check mtu of your wan interface
>> =A0* Try to ping google.com with the maximum size (mtu - 28 bytes, for e=
xample
>> =A0 mtu 1492): ping -M do -s 1464 google.com
>> =A0* Send small tcp packet with small tcp response:
>> =A0 echo "HEAD / HTTP/1.1\nHost: git.open-mesh.net\n\n"|nc git.open-mesh=
.net 80
>>
>> Best regards,
>> =A0 =A0 =A0 =A0Sven
>>
>
