Return-Path: <gwirth79@gmail.com>
Message-ID: <4B3CF7A2.80401@gmail.com>
Date: Thu, 31 Dec 2009 11:12:34 -0800
From: Gus Wirth <gwirth79@gmail.com>
MIME-Version: 1.0
References: <4B3CEF69.40804@gmail.com>
In-Reply-To: <4B3CEF69.40804@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Changeset 1519
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.net

On 12/31/2009 10:37 AM, Gus Wirth wrote:
> I'm looking at changeset 1519 and have a question about the patch to
> routing.c
> 
> On line 158 there is:
> 
> if (neigh_node)
> 
> but later at line 179 there is:
> 
> if (!neigh_node)
> 
> for essential the same functionality.
> 
> Am I confused or is one of these wrong (most likely the first one)?

Never mind. It was fixed in 1520.

Gus
