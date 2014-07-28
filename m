Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 28 Jul 2014 13:34:23 +0200
References: <1406281919-25318-1-git-send-email-sven@narfation.org>
In-Reply-To: <1406281919-25318-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201407281334.23985.sw@simonwunderlich.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Make unix socket path
	configurable
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
Cc: Sven Eckelmann <sven@narfation.org>

> The path to the socket used for client-server communication is currently
> hardcoded in alfred and its complimentary daemons. This makes it hard to
> run two instances of alfred on the same machine without any kind of
> virtualization or containers.
> 
> An user may still want to use two alfred instances to create a test setup
> or connect a single machine two separated alfred data clouds without
> exchanging data between them.

Applied in revision 6c6a6f7.

Thanks!
    Simon
