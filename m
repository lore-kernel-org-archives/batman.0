Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 28 May 2011 00:35:23 +0200
References: <1306534222-11710-1-git-send-email-ordex@autistici.org>
	<201105280020.26937.sven@narfation.org>
In-Reply-To: <201105280020.26937.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105280035.24310.lindner_marek@yahoo.de>
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

On Saturday 28 May 2011 00:20:21 Sven Eckelmann wrote:
> >  struct unicast_frag_packet {
> >       uint8_t  packet_type;
> >       uint8_t  version;  /* batman version field */
> >
> > -     uint8_t  dest[6];
> >
> >       uint8_t  ttl;
> >
> > +     uint8_t  align;
> > +     uint8_t  dest[6];
> >
> >       uint8_t  flags;
> >
> > +     uint8_t  align;
> >
> >       uint8_t  orig[6];
> >       uint16_t seqno;
> >  } __packed;
> 
> Wait a second - are there two "align" in a single struct. Sry, have to
> Nack  that one :)

Yes, I suggested that because the tt patches will replace the first align with 
the ttvn field.

Cheers,
Marek
