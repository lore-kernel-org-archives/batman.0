Return-Path: <andrew@lunn.ch>
Date: Mon, 25 Jan 2010 07:47:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100125064747.GS24649@lunn.ch>
References: <20100123174616.GA4795@Sellars> <20100123181048.GO24649@lunn.ch>
	<20100124204212.GA4350@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20100124204212.GA4350@Sellars>
Subject: Re: [B.A.T.M.A.N.] bat_events: page allocation failure (batman-adv
 maint)
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

Staging: batman-adv: Fix skbuff leak in VIS code.

The vis code takes a copy of the data inside the skbuf if it is interesting=
=20
for us, so we always need to release the skbuf.

Reported-by: Linus L=FCssing <linus.luessing@web.de>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Index: routing.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- routing.c	(revision 1563)
+++ routing.c	(working copy)
@@ -1135,21 +1135,22 @@
 	if (is_my_mac(vis_packet->sender_orig))
 		return NET_RX_DROP;
=20
+	/* We take a copy of the data in the packet, so we should
+	   always free the skbuf. */
+	ret =3D NET_RX_DROP;
+=09
 	switch (vis_packet->vis_type) {
 	case VIS_TYPE_SERVER_SYNC:
 		/* TODO: handle fragmented skbs properly */
 		receive_server_sync_packet(vis_packet, skb_headlen(skb));
-		ret =3D NET_RX_SUCCESS;
 		break;
=20
 	case VIS_TYPE_CLIENT_UPDATE:
 		/* TODO: handle fragmented skbs properly */
 		receive_client_update_packet(vis_packet, skb_headlen(skb));
-		ret =3D NET_RX_SUCCESS;
 		break;
=20
 	default:	/* ignore unknown packet */
-		ret =3D NET_RX_DROP;
 		break;
 	}
 	return ret;
