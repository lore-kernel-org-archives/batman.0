Return-Path: <an.langer@gmx.de>
Date: Tue, 6 Jul 2010 20:17:53 +0200
From: Andreas Langer <an.langer@gmx.de>
Message-ID: <20100706201753.2bcbc369@rechenknecht>
In-Reply-To: <20100706173956.GA9429@ritirata.org>
References: <20100706175814.6927f767@rechenknecht>
	<1278431960-4636-2-git-send-email-an.langer@gmx.de>
	<20100706173956.GA9429@ritirata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Antonio,
thanks for the question. The timeout came up to my mind just in that moment.
I don't know if 5000/10000 be a better value, has somebody else an opinion
regarding that matter ?

regards,
Andreas

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
> 
> Could 5000/10000 be a better value?
> 
> Regards,
> 
> 

