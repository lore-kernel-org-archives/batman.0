Return-Path: <viro@ftp.linux.org.uk>
Date: Wed, 11 Dec 2013 08:05:04 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20131211080504.GT10323@ZenIV.linux.org.uk>
References: <cover.1386738050.git.joe@perches.com>
 <e7104b35287b1e1ec456734c1b5e1aa98dac99f8.1386738050.git.joe@perches.com>
 <20131211075526.GR10323@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131211075526.GR10323@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [B.A.T.M.A.N.] [PATCH -next 2/3] batman-adv: Use seq_overflow
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
To: Joe Perches <joe@perches.com>
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Antonio Quartulli <antonio@meshcoding.com>, "David S. Miller" <davem@davemloft.net>, Marek Lindner <mareklindner@neomailbox.ch>

On Wed, Dec 11, 2013 at 07:55:26AM +0000, Al Viro wrote:

> This sucker should return 0.  Insufficiently large buffer will be handled
> by caller, TYVM, if you give that caller a chance to do so.  Returning 1
> from ->show() is a bug in almost all cases, and definitely so in this one.
> 
> Just in case somebody decides that above is worth copying: It Is Not.
> Original code is buggy, plain and simple.  This one trades the older
> bug ("fail with -EINVAL whenever the buffer is too small") with just as buggy
> "silently skip an entry entirely whenever the buffer is too small".
> 
> Don't Do That.

Pardon - Joe has made seq_overflow return -1 instead of true.  Correction
to the above, then - s/This trades.*\./This is just as buggy./

Conclusion is still the same - Don't Do That.  Returning -1 on insufficiently
large buffer is a bug, plain and simple.

And this patch series is completely misguided - it doesn't fix any bugs
*and* it provides a misleading example for everyone.  See the reaction
right in this thread, proposing to spread the same bug to currently
working iterators.
