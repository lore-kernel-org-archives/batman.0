Return-Path: <kartik@corenetdynamics.com>
MIME-Version: 1.0
In-Reply-To: <20170816144705.GA11501@otheros>
References: <CA+DjzFb8JV2opdLOTaPdm0wNXh95fvQSBcTdreUSmEQrVn5tKQ@mail.gmail.com>
 <20170816144705.GA11501@otheros>
From: Kartikeswar Koppula <kartik@corenetdynamics.com>
Date: Wed, 16 Aug 2017 17:05:27 +0200
Message-ID: <CACXSwgqOdKHyebqYhX2aqZo5mJx08B8M2W4uObRor0f-UfwxUg@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Manually Updating Translation table
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

HI Linus,

Thanks a lot for the reply. I will try to do what you have described.

I am trying to use BATMAN for mesh networking of mobile Networks,
where the Mobile Gateway would be the BATMAN Node and UE (Client) is
not a batman node.
So I want to add UE's entry in Mobile Gateway's local translation
table manually which will be broadcast-ed in OGM to other Mobile
Gateway BATMAN nodes thereby UE's (clients) connected to other
Gateway's will be able to reach UE's connected to first mobile
gateway.

Best Regards,
Kartik

On Wed, Aug 16, 2017 at 4:47 PM, Linus L=C3=BCssing <linus.luessing@c0d3.bl=
ue> wrote:
> Hi,
>
> Currently, no there isn't. The only thing you could do to manually
> add an entry from inside a node is by crafting a dummy packet with
> the desired ethernet source address and transmit it on bat0. That
> way batman-adv would add that MAC address. Deleting only happens
> after a timeout though, no way to force it manually.
>
> In case you are thinking about implementing such a feature:
> The Linux bridge has a feature like that to update the FDB
> (forwarding database, for unicast addresses) or MDB (multicast
> database). It uses netlink for that and you can use
> /usr/sbin/bridge to easily add and remove entries from userspace.
> That'd probably be the approach to mimic in batman-adv for such a
> feature.
>
> Regards, Linus
>
> PS: Out of curiousity, could you share what you'd need such a
> feature for?
>
>
> On Wed, Aug 16, 2017 at 03:57:29PM +0200, Kartikeswar K wrote:
>> Dear BATMAN Community members,
>>
>> I am new to BATMAN Mesh network and looking forward for answer to my
>> query related to updating Local Translation Table in a BATMAN Node.
>>
>> I would like to make a mesh network where I would like to update the
>> client entry in Local Translation manually. Is it possible to add the
>> entry manually in translation table?
>> If so, I would like to know how can I update this table in BATMAN from
>> user space?
>>
>> Thanks in advance and would appreciate your responses.
>>
>> Thanks & Regards,
>> Kartikeswar Koppula
>> kartikeswar@gmail.com
