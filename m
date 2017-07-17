Return-Path: <corbet@lwn.net>
Date: Mon, 17 Jul 2017 15:05:08 -0600
From: Jonathan Corbet <corbet@lwn.net>
Message-ID: <20170717150508.108cfeeb@lwn.net>
In-Reply-To: <20170712111448.30712-1-sven@narfation.org>
References: <20170712111448.30712-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Convert batman-adv.txt to
 reStructuredText
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, linux-doc@vger.kernel.org

On Wed, 12 Jul 2017 13:14:48 +0200
Sven Eckelmann <sven@narfation.org> wrote:

> Converting the freeform text to parsable reStructuredText, allows the
> integration in the sphinx based documentation system of the kernel. It wi=
ll
> therefore be accessible as hypertext under
> https://www.kernel.org/doc/html/latest/

=46rom a quick look-through this looks good.  However, davem likes to take
networking documentation work through his tree; may I suggest a repost
with netdev included?

Thanks,

jon
