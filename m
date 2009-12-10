Return-Path: <zoobab@gmail.com>
MIME-Version: 1.0
Sender: zoobab@gmail.com
In-Reply-To: <618743.16485.qm@web111609.mail.gq1.yahoo.com>
References: <391345.99048.qm@web111612.mail.gq1.yahoo.com>
	<20091209063411.GJ29768@lunn.ch>
	<618743.16485.qm@web111609.mail.gq1.yahoo.com>
Date: Thu, 10 Dec 2009 10:59:12 +0100
Message-ID: <560c7c9a0912100159k23099395pc944e43eda85ac84@mail.gmail.com>
From: Benjamin Henrion <bh@udev.org>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] general theory question RE: dhcp on a peer only
	mesh
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Wed, Dec 9, 2009 at 9:35 PM, George Sanders <gosand1982@yahoo.com> wrote:
> Hello,
>
>
>> > My question is:
>> >
>> > Who provides IP addresses in a truly ad-hoc, truly "peer only" mesh network ?
>>
>> One option is IPv6 and link local addresses. These are derived from
>> the MAC address, plus duplicate address detection, to ensure the IP
>> address is unique. http://tools.ietf.org/html/rfc4862
>>
>> Another option is zeroconf, http://en.wikipedia.org/wiki/Zeroconf,
>> http://tools.ietf.org/html/rfc3927.
>>
>> Another option is statically configure all the boxes with a unique IP
>> address from a well know subnet. It is often worth remembering that a
>> truly ad-hoc, truly "peer only" mesh network is used within some sort
>> of organization. The organization can impose management rules.
>
>
>
> Yes, I do agree that many real world ad-hoc networks will be deployed by an organized
> group and that we can speak of pre-existing arrangements, or rules, but I am exploring
> the extreme cases where individuals randomly congregate and have nothing but a
> common toolset, and there are no server "roles" being played.
>
> Thank you for the pointer to zeroconf, as it is right along the lines of what I was thinking
> about.
>
> Out of curiousity, what does the freifunk network use for assigning IPs ?

In Brussels, PhilV wrote a patch to udhcpd assign 10.x.x.x adresses
from the last digits of the MAC address:

http://reseaucitoyen.be/wiki/index.php/PatchesUdhcpd
http://bulles.topgame.be/ReseauCitoyen/udhcp.patch

-- 
Benjamin Henrion <bhenrion at ffii.org>
FFII Brussels - +32-484-566109 - +32-2-4148403
"In July 2005, after several failed attempts to legalise software
patents in Europe, the patent establishment changed its strategy.
Instead of explicitly seeking to sanction the patentability of
software, they are now seeking to create a central European patent
court, which would establish and enforce patentability rules in their
favor, without any possibility of correction by competing courts or
democratically elected legislators."
