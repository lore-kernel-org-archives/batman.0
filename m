Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 17 Jun 2011 07:55:30 +0200
References: <1308220627-27164-1-git-send-email-lindner_marek@yahoo.de>
	<20110616132149.GB6077@ritirata.org>
In-Reply-To: <20110616132149.GB6077@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201106170755.30634.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix cleanup in
	send_tt_request()
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

On Thursday, June 16, 2011 03:21:49 PM Antonio Quartulli wrote:
> On gio, giu 16, 2011 at 12:37:07 +0200, Marek Lindner wrote:
> > The ret variable was never set to any value other than 0, therefore
> > the skb and tt_req_node would not be freed in case of an error.
> > Furthermore, the code assumed tt_req_node being always a valid
> > pointer by dereferencing it in the cleanup part.
> >
> > 
> >
> > Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>
> 
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision 74db080.

Thanks,
Marek
