Return-Path: <viro@ftp.linux.org.uk>
Date: Wed, 11 Dec 2013 07:58:52 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20131211075852.GS10323@ZenIV.linux.org.uk>
References: <cover.1386738050.git.joe@perches.com>
 <e7104b35287b1e1ec456734c1b5e1aa98dac99f8.1386738050.git.joe@perches.com>
 <52A813C1.8070404@meshcoding.com> <52A814D7.1060805@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52A814D7.1060805@meshcoding.com>
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>, Marek Lindner <mareklindner@neomailbox.ch>

On Wed, Dec 11, 2013 at 08:31:35AM +0100, Antonio Quartulli wrote:
> Joe,
> 
> we have other places in the batman-adv code where we use seq_printf, but
> at the moment we don't check the return value and we always return 0 at
> the end of the function.
> 
> I think we could use seq_overflow here as well?

Not if you want correctly behaving code...
