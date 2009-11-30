Return-Path: <andrew@lunn.ch>
Date: Mon, 30 Nov 2009 11:09:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091130100902.GE10269@lunn.ch>
References: <20091129200950.GA19275@pandem0nium>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091129200950.GA19275@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Removing the big batman lock
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Sun, Nov 29, 2009 at 09:09:50PM +0100, Simon Wunderlich wrote:

> I did some testing, including loading, unloading, killing individual
> nodes etc, which seems to be clean so far. However there might be 
> more race conditions introduced by this large patch, and i'm therefore
> requesting a careful review before committing.

Hi Simon

I've not done a careful review yet, just a quick look.

Two idea for improvements:

In the purge code, add some debug code which looks at the refcount
value. If it is not between 1 and 5, prinkt() a warning what there is
probably a missing refcount operation. Since the purge code does not
run very often, it should not add much overhead, yet it is still a
useful debug tool.

The following bit of code happens quite a lot:

while (NULL != (orig_node = orig_hash_iterate(&hashit, orig_node))) {


There is also a comment about having to free hashit, if you don't
iterate to the end of the hash. How about refactoring this, more like
the linux list.h.

Make hashit a stack variable, with an init macro:

#define HASHIT(name) struct hash_it_t name = { .index = -1, .bucket = NULL, \
	                                       .prev_bucket=NULL,           \
 					       .first_bucket=NULL }

and a macro for iterating over the hash
    
    HASHIT(hashit);

    orig_hash_for_each(orig_node, hashit) {

    foo(orig_node);
    }


    Andrew
