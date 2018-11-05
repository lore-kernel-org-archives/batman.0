Return-Path: <jiri@mellanox.com>
From: Jiri Pirko <jiri@mellanox.com>
Date: Mon, 5 Nov 2018 11:17:08 +0000
Message-ID: <20181105111050.GA2095@nanopsycho>
References: <20181104193314.18104-1-sven@narfation.org>
 <20181104193314.18104-2-sven@narfation.org>
In-Reply-To: <20181104193314.18104-2-sven@narfation.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <921398203049234D8292EAB189CEEC3D@eurprd05.prod.outlook.com>
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

Sun, Nov 04, 2018 at 08:33:13PM CET, sven@narfation.org wrote:
>The batman-adv configuration interface was implemented solely using sysfs.
>This approach was condemned by non-batadv developers as "huge mistake".
>Instead a netlink/genl based implementation was suggested.
>
>The different key-value pairs used for the configuration of batman-adv can
>be split in three classes (sharing most of the setup code):

This is problematic. In general, TLV approach is frowned upon.
What is a usual way of exposing options over netlink are well-defined
netlink attributes. For example:

BATADV_ATTR_SOME_THING
BATADV_ATTR_ANOTHER_THING

The set and get commands usually work with an object. So if and object
have multiple options/attributes, it can we set via a single set
command. But this is more free. Depends on what makes more sense.


>
>* mesh interface (the batadv device)
>* hard interface specific  (the enslaved devices)
>* vlan specific (vlan on top of the mesh interface)
>
>For all three, genl commands to get, set and dump are specified. The actua=
l
>modification of datastructures is then trivial and abstracted away from th=
e
>genl handing via objects with callbacks (get, validate, set). The option
>infrastructure is handling the actual retrieval of mesh interface object,
>hard interface object and vlan object. It takes care of validation and
>issuing netlink mcast messages back to userspace.
>
>TODO add more description here.
>
