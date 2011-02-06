Return-Path: <ks@kevinsteen.net>
Message-ID: <4D4F1E31.4040200@kevinsteen.net>
Date: Sun, 06 Feb 2011 22:18:25 +0000
From: Kevin Steen <ks@kevinsteen.net>
MIME-Version: 1.0
References: <201101282346.16035.clemens-john@gmx.de>	<201101311933.01581.clemens-john@gmx.de>	<4D47E5A4.2020005@kevinsteen.net>
	<201102041638.54751.clemens-john@gmx.de>
In-Reply-To: <201102041638.54751.clemens-john@gmx.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] Connecting through Batman advanced interface
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

On 04/02/11 15:38, Clemens John wrote:
> Am Dienstag 01 Februar 2011, 11:51:16 schrieben Sie:
>> If your non-batman clients don't need incoming connections, you could
>> NAT outgoing connections :
>>     [client]-->[adhoc ath1]-->NAT-->[br-mesh]
>> You would have to run a DHCP server on the ath1 interface to give those
>> clients a private IP and tell them to use the private IP on ath1 as
>> their router.
> What do I have do insert into iptables to NAT ath1 to br-mesh? I=B4m a co=
mplete
> firewall noob.
There might be an easier way using the config files of the distribution=20
you're using, but from a script it would look something like this:

#! /bin/sh
modprobe iptable_nat
## Work-around for bad ISPs which drop ICMP Fragmentation Needed=20
packets: (Needs to be early in list)
iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS=20
--clamp-mss-to-pmtu
iptables -t nat -A POSTROUTING -o br-mesh -j MASQUERADE

-Kevin

