Return-Path: <davem@davemloft.net>
Date: Wed, 15 Jan 2014 16:54:41 -0800 (PST)
Message-Id: <20140115.165441.1381803061248668589.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <52D68A1C.3080302@meshcoding.com>
References: <1389652298-472-1-git-send-email-antonio@meshcoding.com>
 <1389652298-472-15-git-send-email-antonio@meshcoding.com>
 <52D68A1C.3080302@meshcoding.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 14/14] batman-adv: drop dependency
	against CRC16
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
To: antonio@meshcoding.com
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 15 Jan 2014 14:16:12 +0100

> On 13/01/14 23:31, Antonio Quartulli wrote:
>> The crc16 functionality is not used anymore, therefore
>> we can safely remove the dependency in the Kbuild file.
>> 
>> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> 
> David,
> 
> we just realized that this dependency is still needed by our module.
> (also thanks to Fengguang Wu build bot!)
> 
> Could you please revert this patch only?

I've reverted this change from net-next, thanks.
