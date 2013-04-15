Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 15 Apr 2013 17:27:35 +0800
References: <1364897813-19421-1-git-send-email-ordex@autistici.org>
 <20130402102250.GJ4024@ritirata.org>
In-Reply-To: <20130402102250.GJ4024@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201304151727.36146.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: don't initialise batman_iv
	private members in hard-interface.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

On Tuesday, April 02, 2013 18:22:50 Antonio Quartulli wrote:
>   On Tue, Apr 02, 2013 at 12:16:53PM +0200, Antonio Quartulli wrote:
> > From: Antonio Quartulli <antonio@open-mesh.com>
> >
> > 
> >
> > hard-interface.c has to do not contain any routing algorithm
> > specific code.
> >
> > 
> >
> > Allocate the hard-interface with kzalloc() and remove any
> > useless and algorithm specific member initialisation
> >
> > 
> >
> > Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> > ---
> 
> For whoever is concerned about this missing initialisations, I have to say
> that those are done in the routing specific API function upon
> hard-interface activation. Meaning that the seqno and the ogm_buff are
> initialised somewhere else before being used.
> 
> However, using kzalloc, ensure that all the members are initialised to 0
> after allocation.

Applied in revision 1cc6cbc.

Thanks,
Marek
