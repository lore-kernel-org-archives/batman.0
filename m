Return-Path: <jiri@mellanox.com>
From: Jiri Pirko <jiri@mellanox.com>
Date: Mon, 5 Nov 2018 11:54:12 +0000
Message-ID: <20181105114754.GE2095@nanopsycho>
References: <20181104193314.18104-1-sven@narfation.org>
 <20181104193314.18104-2-sven@narfation.org>
 <20181105111050.GA2095@nanopsycho> <39526497.qhSXs3GhTV@bentobox>
In-Reply-To: <39526497.qhSXs3GhTV@bentobox>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F2E93F9FDB4644989F417A1ACE8017A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add infrastructure for
 netlink config manipulation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Mon, Nov 05, 2018 at 12:33:25PM CET, sven@narfation.org wrote:
>On Montag, 5. November 2018 11:17:08 CET Jiri Pirko wrote:
>> Sun, Nov 04, 2018 at 08:33:13PM CET, sven@narfation.org wrote:
>> >The batman-adv configuration interface was implemented solely using sys=
fs.
>> >This approach was condemned by non-batadv developers as "huge mistake".
>> >Instead a netlink/genl based implementation was suggested.
>> >
>> >The different key-value pairs used for the configuration of batman-adv =
can
>> >be split in three classes (sharing most of the setup code):
>>=20
>> This is problematic. In general, TLV approach is frowned upon.
>> What is a usual way of exposing options over netlink are well-defined
>> netlink attributes. For example:
>>=20
>> BATADV_ATTR_SOME_THING
>> BATADV_ATTR_ANOTHER_THING
>>=20
>> The set and get commands usually work with an object. So if and object
>> have multiple options/attributes, it can we set via a single set
>> command. But this is more free. Depends on what makes more sense.
>
>Hm, so you first  say that I should not do that and then say that it can b=
e=20
>done because it operates on the same object? Classes in my description are=
=20
>basically your object.

The API needs to be well-defined. That, you can do by defining ATTRs.
But with TVLs, that cannot be be done. API is NAME-VALUE and user does
not really see what "NAME" he can pass down, as it is parsed later on in
batman code. That is my point. To have all options as well-defined
netlink attributes with types (for netlink policy purposes).


>
>But let assume for now that you don't want to use this approach, we can al=
so=20
>have for example something like:
>
>BATADV_CMD_SET_BRIDGE_LOOP_AVOIDANCE which then receives either one or no =
flag=20
>BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE to enable/disable bridge loop avoidance.=
 And=20
>a command BATADV_CMD_GET_BRIDGE_LOOP_AVOIDANCE which tells the client usin=
g=20
>BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE whether it was enabled or not. A dump=20
>functionality for all options for this batadv object/class would then not=
=20
>exist.

Got it. That is possible to do it this way. But if you would be able to
group the attrs somehow, that would be probably nice. 1:1 mapping
between cmds and attrs looks a bit weird.

Sidenote: I suggest not to use NLA_FLAG attribute type. Better to use
NLA_U8 of value 0/1. NLA_FLAG missing in message might mean 2 things:
1) user wants to set false
2) user is old and does not support this attribute



>
>Kind regards,
>	Sven


