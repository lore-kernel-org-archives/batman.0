Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 8 Mar 2010 23:21:02 +0800
References: <20100308151244.GA4468@lunn.ch>
In-Reply-To: <20100308151244.GA4468@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201003082321.03064.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] FWD: batman: potential null dereference
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

On Monday 08 March 2010 23:12:44 Andrew Lunn wrote:
> Does somebody have time to look at this?

As far as I understand the question is: What happens if 
!orig_node->router && !neigh_node go into update_route() ?

Fairly easy to answer: Only update_routes() (note the "s") calls 
update_route() which checks for this case:

if (orig_node->router != neigh_node)
	update_route()

Not very obvious though ...


Regards,
Marek


PS: Can we somehow better communicate that we have a mailing list for these 
kind of questions ?

