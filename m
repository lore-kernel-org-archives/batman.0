Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 4 May 2012 15:48:50 +0800
References: <1335690403-25228-1-git-send-email-sven@narfation.org>
	<201205041534.18504.lindner_marek@yahoo.de>
	<1398273.h5rYArleKn@bentobox>
In-Reply-To: <1398273.h5rYArleKn@bentobox>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201205041548.50448.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Free local translation
	table on error in tt_init
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

On Friday, May 04, 2012 15:43:14 Sven Eckelmann wrote:
> On Friday, May 04, 2012 03:34:18 PM Marek Lindner wrote:
> > On Sunday, April 29, 2012 17:06:42 Sven Eckelmann wrote:
> > > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > > ---
> > > 
> > >  translation-table.c |    4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/translation-table.c b/translation-table.c
> > > index 88c62f1..c3b7773 100644
> > > --- a/translation-table.c
> > > +++ b/translation-table.c
> > > @@ -1776,8 +1776,10 @@ int tt_init(struct bat_priv *bat_priv)
> > > 
> > >  	if (!tt_local_init(bat_priv))
> > >  	
> > >  		return 0;
> > > 
> > > -	if (!tt_global_init(bat_priv))
> > > +	if (!tt_global_init(bat_priv)) {
> > > +		tt_local_table_free(bat_priv);
> > > 
> > >  		return 0;
> > > 
> > > +	}
> > > 
> > >  	tt_start_timer(bat_priv);
> > 
> > Is this really necessary ? If tt_init() fails mesh_free() is called to
> > free all tt buffers / lists / hashes. This is how the other *_init()
> > function calls do it as well.
> 
> Ok, forgot about that. It is just became "normal" for me to assume that the
> local function is cleaning their stuff and does not "leak" in error
> situations.

Yes, I had the same thought at the beginning. If we change this function we 
also should change all other _init() functions, no ? Simply to be consistent ?

Regards,
Marek
