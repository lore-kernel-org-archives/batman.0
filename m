Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 May 2013 14:42:01 +0800
References: <1368960916-861-1-git-send-email-ordex@autistici.org>
 <20130519115225.GA16839@pandem0nium>
In-Reply-To: <20130519115225.GA16839@pandem0nium>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201305241442.01813.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: use htons when possible
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Sunday, May 19, 2013 19:52:25 Simon Wunderlich wrote:
> On Sun, May 19, 2013 at 12:55:16PM +0200, Antonio Quartulli wrote:
> > When comparing a network ordered value with a constant, it
> > is better to convert the constant at compile time by means
> > of htons() instead of converting the value at runtime using
> > ntohs().
> >
> > This refactoring may slightly improve the code performance.
> >
> > Moreover substitute __constant_htons() with htons() since
> > the latter increase readability and it is smart enough to be
> > as efficient as the former
> >
> > Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> > ---
> >
> > v2:
> > - patch rebased on top of
> > "batman-adv: use VLAN_ETH_HLEN instead of sizeof(struct vlan_eth_hdr)"
> >
> > v3:
> > - use __constant* for vlan_insert_tag() argument
> >
> > v4:
> > - use htons instead of __constant_htons
> 
> Looks good, using htons is a lot better. :)
> 
> Acked-by: Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

Applied in revision 4a4f6b9.

Thanks,
Marek
