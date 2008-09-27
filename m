From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 28 Sep 2008 01:20:56 +0800
References: <200809271831.18672.sven.eckelmann@gmx.de>
In-Reply-To: <200809271831.18672.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809280120.56880.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Possible null pointer dereference in batman's
	update_routes
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

> I am not sure but I think it could be possible that there is a null pointer
> dereference at batman.c:420
> I assume that it is possible that neigh_node is NULL and orig_node->router
> is also NULL in batman.c:412. Now we dereference neigh_node in batman.c:420
> as third parameter of add_del_route.
> I don't know if the third parameter should be set to 0 if neigh_node is
> NULL or if the "if"-statement is wrong - so i will not send a patch this
> time.

this one is a bit tricky (may be we should add a comment there). In line 386 
we prevent that null pointer dereference:

orig_node->router != neigh_node

If both variables are NULL it would fail here.  :-)


Greetings,
Marek



