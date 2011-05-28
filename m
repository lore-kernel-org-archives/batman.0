Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 28 May 2011 13:20:02 +0200
References: <1306534222-11710-1-git-send-email-ordex@autistici.org>
	<201105280035.24310.lindner_marek@yahoo.de>
	<201105280926.32059.sven@narfation.org>
In-Reply-To: <201105280926.32059.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105281320.03020.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move the ttl field to the
	third position of unicast_* packets
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

On Saturday 28 May 2011 09:26:30 Sven Eckelmann wrote:
> > Yes, I suggested that because the tt patches will replace the first align
> > with the ttvn field.
> 
> But it doesn't compile. I cannot forward stuff which is too broken. And
> personally I don't care who suggested it when my builtin c-parser explodes.

You got a point here.  :-)


> My suggestion: Rename the first align in every packet structure to
> 'reserved'.

Ok.


> Then to the next part which I don't like: the patch forgot to touch
> batman_packet, icmp_packet, icmp_packet_rr, bcast_packet and vis_packet. It
> doesn't make sense to patch half of the on-wire types to reduce the number
> of COMPAT_VERSIONs.

If we touch every packet definition we also have to ensure that the code 
touching these packets does not implicitly assume certain positions (like 
route_unicast_packet() does).

Regards,
Marek
