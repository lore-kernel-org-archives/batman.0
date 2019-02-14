Return-Path: <jiri@mellanox.com>
From: Jiri Pirko <jiri@mellanox.com>
Date: Thu, 14 Feb 2019 14:16:06 +0000
Message-ID: <20190214140633.GI2363@nanopsycho>
References: <20190214124301.6222-1-linus.luessing@c0d3.blue>
 <1687264.beubBEU3KB@bentobox> <20190214134452.GA1602@otheros>
In-Reply-To: <20190214134452.GA1602@otheros>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0A6B2D378DC7854EA19AD1ED533BBFCE@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: Add multicast-to-unicast
 support for multiple targets
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: =?iso-8859-1?Q?Linus_L=FCssing?= <linus.luessing@c0d3.blue>
Cc: Sven Eckelmann <sven@narfation.org>, "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, David Bauer <mail@david-bauer.net>

Thu, Feb 14, 2019 at 02:44:52PM CET, linus.luessing@c0d3.blue wrote:
>On Thu, Feb 14, 2019 at 01:46:35PM +0100, Sven Eckelmann wrote:
>> On Thursday, 14 February 2019 13:43:01 CET Linus L=FCssing wrote:
>> >=20
>> > +What:           /sys/class/net/<mesh_iface>/mesh/multicast_fanout
>> > +Date:           Feb 2019
>> > +Contact:        Linus L=FCssing <linus.luessing@c0d3.blue>
>> > +Description:
>> > +                Defines the maximum number of packet copies that may
>> > +               be generated for a multicast-to-unicast conversion.
>> > +               Once this limit is exceeded distribution will fall
>> > +               back to broadcast.
>> > +
>>=20
>> No new sysfs config files.
>
>Why? The bridge for instance does the same.

I would recommend to add new options only to netlink to force userspace
tools to use it  and eventually phase-out sysfs usage..
