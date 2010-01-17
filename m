Return-Path: <Jaideep.Lamba@alcatel-lucent.com>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Jan 2010 18:06:55 -0600
Message-ID: <EACB115D0487C4459885C4B54EE8D9CF05D74AAD@USDALSMBS02.ad3.ad.alcatel.com>
In-Reply-To: <201001170040.31071.sven.eckelmann@gmx.de>
References: <EACB115D0487C4459885C4B54EE8D9CF05D74AAB@USDALSMBS02.ad3.ad.alcatel.com>
	<201001170040.31071.sven.eckelmann@gmx.de>
From: "LAMBA Jaideep" <Jaideep.Lamba@alcatel-lucent.com>
Subject: Re: [B.A.T.M.A.N.] Security on adhoc network
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
To: Sven Eckelmann <sven.eckelmann@gmx.de>, b.a.t.m.a.n@lists.open-mesh.org

Sven,

I tried WPA_NONE and CCMP with wpa_supplicant on both the sides with
preshared keys. By doing this you are right nobody can see the data and
I get encryption and authentication. But here comes a twist.
Lets say I power off one node completely after initial secure session.
When he comes up wpa_supplicant starts off with 0 as sequence number. On
the other node sequence number might be greater (or way greater) which
causes other node to believe that he is experiencing a MIC_FAILURE
attack.=20

Based on my understanding drivers are needed to sync up TSF in adhoc
networks which will eventually setup the right key and hence establish
the session back. But that's isnt available now.=20

So do we have any layer 2 security on adhoc networks that are currently
being deployed.

Thanks,
Jaideep

>> Are there any solutions currently under implementation for providing=20
>> security (other than open/wep) over adhoc networks ?
>
>What kind of security do you need? Security is a big field. Maybe you
just mean encryption and authentication.....
>
>When you only want to make the whole wlan stuff unreadable for the
outside, you could just use WPA_NONE. But this doesn't resolve the
problem that the key could leak and make the mesh >attackable - but that
is something which could always happen. So it is probably not a solution
for freifunk projects, but for mesh networks controlled by a company.
>
>There are other ideas for traffic over batman-adv. Just forget about
encrypting your data over wifi, but instead do everything some layers
above it. I think Linus had some ideas in implementing the >needed
authentication and encryption over IPsec in a mesh. I am not sure what
his ideas were exactly, but maybe he could add some more information
about that.
>
>And most of the encryption and authentication stuff has to be resolved
by the user and not by the network provider. This means https for
sensible data instead of http, ssh instead of telnet, pop3s >instead of
pop3 and so on.
>
>So it really depends what you want and cannot be resolved in a
"security for everything, against any attack and for every purpose"
blob.
>
>Best regards,
>	Sven
