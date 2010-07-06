Return-Path: <andrew@lunn.ch>
Date: Tue, 6 Jul 2010 20:57:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100706185729.GB18453@lunn.ch>
References: <20100706175814.6927f767@rechenknecht>
	<1278431960-4636-2-git-send-email-an.langer@gmx.de>
	<20100706173956.GA9429@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100706173956.GA9429@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: layer2 unicast packet
 fragmentation
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

On Tue, Jul 06, 2010 at 07:39:56PM +0200, Antonio Quartulli wrote:
> Hi all, Hi Andreas,
> 
> > +#define FRAG_TIMEOUT 60000     /* purge frag list entrys after time in
> > ms */
> 
> Why did you choose a so large timeout? Is there a particular reason for
> that?
> 
> I think that in 60 seconds an host could receive a very large amount of
> "orphan" packets in case of a bad link causing memory problems.

It will not cause memory problems. The linked list is limited to
FRAG_BUFFER_SIZE (6) segments. 

    Andrew
