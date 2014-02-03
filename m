Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 4 Feb 2014 00:16:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20140203211615.GC26776@mwanda>
References: <20140130125206.GA23793@elgon.mountain>
 <52EA5AAB.8080101@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52EA5AAB.8080101@meshcoding.com>
Subject: Re: [B.A.T.M.A.N.] question about min_t() casting in
 batadv_hardif_min_mtu()
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

On Thu, Jan 30, 2014 at 02:59:07PM +0100, Antonio Quartulli wrote:
> 
> But why don't dev_set_mtu() check for the argument to be larger than
> 68bytes? Isn't that a general requirement?

I'm not a networking person.  It sounds reasonable to me that we could
use add a better minimum check there but why is it 68 bytes?

regards,
dan carpenter

