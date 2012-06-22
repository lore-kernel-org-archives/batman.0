Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 22 Jun 2012 20:19:05 +0200
References: <1340205365-25052-1-git-send-email-lindner_marek@yahoo.de>
	<20120620153402.GA17596@ritirata.org>
In-Reply-To: <20120620153402.GA17596@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201206222019.05974.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: only drop packets of known
	wifi clients
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

On Wednesday, June 20, 2012 17:34:03 Antonio Quartulli wrote:
>   On Wed, Jun 20, 2012 at 05:16:05 +0200, Marek Lindner wrote:
> > If the source or destination mac address of an ethernet packet
> > could not be found in the translation table the packet was
> > dropped if AP isolation was turned on. This behavior would
> > make it impossible to send broadcast packets over the mesh as
> > the broadcast address will never enter the translation table.
> >
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision 03a0e3d.

Regards,
Marek
