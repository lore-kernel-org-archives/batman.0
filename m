Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 14 May 2012 17:15:27 +0800
References: <CAG7VhQSjyQRtCZfC9FUr1f+Fxg6mdwFfBJZOyXowhmW7r+a-eA@mail.gmail.com>
	<CAG7VhQQKKv67Qb4ywQmJp7BCvJARRYT29AwBX1rQDgidaCP5iQ@mail.gmail.com>
In-Reply-To: <CAG7VhQQKKv67Qb4ywQmJp7BCvJARRYT29AwBX1rQDgidaCP5iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201205141715.27604.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Possible OGM forwarding misbehavior
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


Hi,

> incidentally I noticed that with the modification that introduced the
> 'NOT_BEST_NEXT_HOP' flag only OGM coming from best next hop neighbour
> are forwarded in case of multi-hop originators.
> 
> The problem is that in the routing code it is forwarded only the first OGM
> received with a fresh sequence number (that could be received from a
> sub-optimal router).
> 
> This means that if the OGM from best next hop neighbour is not received as
> the first OGM, it is not forwarded and I think this can be a problem.
> 
> Maybe it can be better to maintain also an index of the last FORWARDED
> sequence number instead of checking the last RECEIVED sequence number.

do you mind sending a patch for this ? That would make it easier to understand 
what you have in mind.

Regards,
Marek
 
