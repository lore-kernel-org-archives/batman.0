Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 28 May 2011 14:17:14 +0200
References: <1306572183-25950-1-git-send-email-sven@narfation.org>
	<1306583129-4854-1-git-send-email-lindner_marek@yahoo.de>
	<201105281407.15153.sven@narfation.org>
In-Reply-To: <201105281407.15153.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201105281417.16069.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-marek] batman-adv: Unify the first 3
	bytes in each packet
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
To: b.a.t.m.a.n@lists.open-mesh.org

On Saturday 28 May 2011 14:07:10 Sven Eckelmann wrote:
> Why dont you use the reserverd part for the flags which are currently not
> in unicast? Then you could also remove that other align byte. It would
> still be possible to add flags to unicast packets when necessary.

The unicast_frag header assumes it looks like the unicast header plus some 
extra fields:

struct unicast_frag_packet {
	struct unicast_packet unicast_packet;
	uint8_t  flags;
	uint8_t  align;
	uint8_t  orig[6];
	uint16_t seqno;
};

We probably should add a little comment there to make that clear.

Both reserved fields (unicast + unicast frag) are going to be converted to 
ttvn with the tt patches.


> > +	uint8_t  reserved;
> > +	uint8_t  orig[6];
> > 
> >  	uint32_t seqno;
> >  
> >  } __packed;
> 
> Wouldn't that lead to an unaligned seqno?

Yes, I overlooked that the seqno is 32bit wide.

Regards,
Marek
