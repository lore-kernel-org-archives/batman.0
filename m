Return-Path: <willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171205143514.4441-3-sven.eckelmann@openmesh.com>
References: <20171205143514.4441-1-sven.eckelmann@openmesh.com>
 <20171205143514.4441-3-sven.eckelmann@openmesh.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 6 Dec 2017 11:42:33 -0500
Message-ID: <CAF=yD-JxdNu6eFha_V2650-UqZ3KNSzD4Oe2RLHEWd4cz1G6kA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [B.A.T.M.A.N.] [RFC v2 2/6] batman-adv: Rename batman-adv.h to
 batadv_genl.h
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@openmesh.com>
Cc: Network Development <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, Jiri Pirko <jiri@mellanox.com>, Eric Dumazet <edumazet@google.com>, LKML <linux-kernel@vger.kernel.org>, b.a.t.m.a.n@lists.open-mesh.org

On Tue, Dec 5, 2017 at 9:35 AM, Sven Eckelmann
<sven.eckelmann@openmesh.com> wrote:
> This file contains the relevant information to let userspace communicate
> with batman-adv over generic netlink. The relevant genl enums for the
> attributes and commands have the prefix batadv_genl. Renaming this file to
> this name therefore represents the content better and avoids confusion with
> the file which will contain the packet format definitions.
>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
> ---
>  MAINTAINERS                                        | 2 +-
>  include/uapi/linux/{batman_adv.h => batadv_genl.h} | 6 +++---

This and the previous patch changes uapi. That might break userspace
applications that rely on it.
