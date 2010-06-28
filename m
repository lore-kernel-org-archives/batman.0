Return-Path: <nwharton@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201006281840.08381.sven.eckelmann@gmx.de>
References: <AANLkTimCSkFrm9F7DF6HWBBgo4PCb5qmy6xEmeHGonLl@mail.gmail.com>
	<201006281840.08381.sven.eckelmann@gmx.de>
Date: Mon, 28 Jun 2010 12:01:35 -0500
Message-ID: <AANLkTil7STjuod65b5gzPfIunyr81e0H8Bj0gsAWD-yQ@mail.gmail.com>
From: Nathan Wharton <nwharton@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Multicast video over 2 node mesh
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>
Cc: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Jun 28, 2010 at 11:40 AM, Sven Eckelmann <sven.eckelmann@gmx.de> wr=
ote:
> Nathan Wharton wrote:
>> I am having problems getting multicast video over my 2 node mesh. =A0I
>> am building under openwrt and the version is 0.3.0-alpha rv1715.
>
> First thing: multicast is currently implemented over broadcast.
>
>> I have a lan bridge on each side. =A0If I directly add ath0 to the lan
>> bridge the video works fine. =A0But since I want to mesh, I put ath0
>> into bat0 instead, and then I put bat0 into the bridge. =A0This works
>> for all my traffic that put across it so far except the multicast
>> video. =A0A tcpdump comparison of both sides shows that after about 32
>> packets data starts getting dropped. =A0The video is about 1Mbs.
>
> Simon changed to broadcast code some time ago. Maybe it is related. Can y=
ou
> please try to use ethernet to transfer the data between the nodes (so bat=
0
> should only have the ethernet device included). Just as test if it could =
be
> related to midair collisions due to the broadcasts resends or if the broa=
dcast
> code as a general problem.

Connecting them via eth0 and putting eth0 in bat0 works fine, even though
I could not set the mtu of my ethernet device to 1524.  The packets are onl=
y
up to 1400 in size anyway.

>
>> Given this thousand foot view of the problem, is there something
>> obvious I might be missing? =A0I've set the mtu on ath0 to 1524.
>> Everything else seems to work fine, including copying a file over the
>> mesh setup that is 20MB at a speed of 578.9KB/s and the md5sum was
>> right.
>
> File transfers are unicast. So little problematic to compare with your
> situation.
>
> thanks,
> =A0 =A0 =A0 =A0Sven
>
