Return-Path: <linus.luessing@web.de>
Date: Wed, 19 Mar 2014 11:02:07 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20140319100207.GJ5208@Linus-Debian>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
 <1395216532-31099-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1395216532-31099-2-git-send-email-antonio@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 next 02/11] batman-adv: don't mess up
 with the netdev refcounting if not needed
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On Wed, Mar 19, 2014 at 09:08:43AM +0100, Antonio Quartulli wrote:
> Looking for an interface and increasing its refcounter only
> to check if it really exists is not really useful and makes
> the code look more complex without a real gain.

Hm, I was intending to use it somewhere else as well with the
next series of patches. See:
http://git.open-mesh.org/batman-adv.git/commitdiff/bd774bd7e00bbe062cb0ab591d50be77e30a557a?hp=c9c3d53851f832b32188c9dd9a3dace96a33a0c3

But ok, since it is not in a yet scheduled patchset, I guess
you're right, then it should better be introduced when it is
needed.

On another note, I think you're introducing a bug/memoryleak
here for the compat-code case for
netdev_master_upper_dev_get_rcu().

Cheers, Linus
