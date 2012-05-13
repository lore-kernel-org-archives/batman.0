Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAG7VhQSjyQRtCZfC9FUr1f+Fxg6mdwFfBJZOyXowhmW7r+a-eA@mail.gmail.com>
References: <CAG7VhQSjyQRtCZfC9FUr1f+Fxg6mdwFfBJZOyXowhmW7r+a-eA@mail.gmail.com>
Date: Sun, 13 May 2012 10:56:02 +0200
Message-ID: <CAG7VhQQKKv67Qb4ywQmJp7BCvJARRYT29AwBX1rQDgidaCP5iQ@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Possible OGM forwarding misbehavior
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

Hi all,
incidentally I noticed that with the modification that introduced the
'NOT_BEST_NEXT_HOP' flag only OGM coming from best next hop neighbour
are forwarded in case of multi-hop originators.

The problem is that in the routing code it is forwarded only the first OGM
received with a fresh sequence number (that could be received from a
sub-optimal router).

This means that if the OGM from best next hop neighbour is not received as
the first OGM, it is not forwarded and I think this can be a problem.

Maybe it can be better to maintain also an index of the last FORWARDED
sequence number instead of checking the last RECEIVED sequence number.

Regards

--
Daniele Furlan
