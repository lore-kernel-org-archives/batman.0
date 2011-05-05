Return-Path: <ordex@autistici.org>
Date: Thu, 5 May 2011 09:24:54 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20110505072454.GB5527@ritirata.org>
References: <1304550695-6922-1-git-send-email-ordex@autistici.org>
	<1304577807-16450-1-git-send-email-ordex@autistici.org>
	<201105050905.20271.sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201105050905.20271.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batctl: rename stuff from *hna* to
 *tt* (translation table)
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Thu, May 05, 2011 at 09:05:18AM +0200, Sven Eckelmann wrote:
> > diff --git a/packet.h b/packet.h
> > index e757187..c225c3a 100644
> > --- a/packet.h
> > +++ b/packet.h
> > @@ -61,7 +61,7 @@ struct batman_packet {
> >  	uint8_t  orig[6];
> >  	uint8_t  prev_sender[6];
> >  	uint8_t  ttl;
> > -	uint8_t  num_hna;
> > +	uint8_t  num_tt;
> >  	uint8_t  gw_flags;  /* flags related to gateway class */
> >  	uint8_t  align;
> >  } __packed;
> 
> Modified stuff in batctl/packet.h must also be changed in batman-adv/packet.h 
> at the same time.
> 
> Kind regards,
> 	Sven

Hi Sven,

I sent "[PATCHv3] batman-adv: rename everything from *hna* into *tt*
(translation table)" at the same time with these and other changes.

Thanks,


-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara
