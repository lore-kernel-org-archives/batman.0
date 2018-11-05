Return-Path: <jiri@mellanox.com>
From: Jiri Pirko <jiri@mellanox.com>
Date: Mon, 5 Nov 2018 14:00:00 +0000
Message-ID: <20181105135341.GA2204@nanopsycho.orion>
References: <20181104193314.18104-1-sven@narfation.org>
 <39526497.qhSXs3GhTV@bentobox> <20181105114754.GE2095@nanopsycho>
 <2356284.qJOkjcCIOy@bentobox>
In-Reply-To: <2356284.qJOkjcCIOy@bentobox>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <72A184DB7EC1544EAEFCE9BFA71E332A@eurprd05.prod.outlook.com>
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

Mon, Nov 05, 2018 at 01:41:17PM CET, sven@narfation.org wrote:
>On Montag, 5. November 2018 11:54:12 CET Jiri Pirko wrote:
>[...]
>> >
>> >But let assume for now that you don't want to use this approach, we can=
 also=20
>> >have for example something like:
>> >
>> >BATADV_CMD_SET_BRIDGE_LOOP_AVOIDANCE which then receives either one or =
no flag=20
>> >BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE to enable/disable bridge loop avoidan=
ce. And=20
>> >a command BATADV_CMD_GET_BRIDGE_LOOP_AVOIDANCE which tells the client u=
sing=20
>> >BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE whether it was enabled or not. A dump=
=20
>> >functionality for all options for this batadv object/class would then n=
ot=20
>> >exist.
>>=20
>> Got it. That is possible to do it this way. But if you would be able to
>> group the attrs somehow, that would be probably nice. 1:1 mapping
>> between cmds and attrs looks a bit weird.
>>=20
>> Sidenote: I suggest not to use NLA_FLAG attribute type. Better to use
>> NLA_U8 of value 0/1. NLA_FLAG missing in message might mean 2 things:
>> 1) user wants to set false
>> 2) user is old and does not support this attribute
>
>Ok, let me suggest something more specific (just to make sure we talk abou=
t=20
>the same thing). We could use the commands:
>
>+       /**
>+        * @BATADV_CMD_GET_OPTION: Get option(s) from softif
>+        */
>+       BATADV_CMD_GET_OPTION,
>+
>+       /**
>+        * @BATADV_CMD_SET_OPTION: Set option for softif
>+        */
>+       BATADV_CMD_SET_OPTION,
>+
>+       /**
>+        * @BATADV_CMD_GET_OPTION_HARDIF: Get option(s) from a hardif of t=
he
>+        *  current softif
>+        */
>+       BATADV_CMD_GET_OPTION_HARDIF,
>+
>+       /**
>+        * @BATADV_CMD_SET_OPTION_HARDIF: Set option for hardif of the
>+        *  current softif
>+        */
>+       BATADV_CMD_SET_OPTION_HARDIF,
>+
>+       /**
>+        * @BATADV_CMD_GET_OPTION_VLAN: Get option(s) from a VLAN of the
>+        *  current softif
>+        */
>+       BATADV_CMD_GET_OPTION_VLAN,
>+
>+       /**
>+        * @BATADV_CMD_SET_OPTION_VLAN: Set option for VLAN of the
>+        *  current softif
>+        */
>+       BATADV_CMD_SET_OPTION_VLAN,
>+
>
>But instead of using BATADV_ATTR_OPTION_NAME+BATADV_ATTR_OPTION_TYPE+
>BATADV_ATTR_OPTION_VALUE to send the infos up, we have a number of specifi=
c=20
>netlink attributes [e.g. BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE (u8)] that are =
used=20
>to exchange the value directly.  Multiple attributes can be in the message=
s=20

Yes. That sounds fine.


>and dumping is possible but maybe requires to split all option in multiple=
=20
>messages. Informational dumping (user readable) is then only possible when=
 the=20
>userspace part also knows all attributes. And sending things to the kernel=
 is=20
>only possible when the userspace also has explicit support for the attribu=
te.

Yes.

>
>This is at least similar to how I did it in two previous projects but drop=
ped=20
>this approach when I saw that it was implemented differently for devlink a=
nd=20
>team.
>
>Thanks,
>	Sven


