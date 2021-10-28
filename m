Return-Path: <a@unstable.cc>
Subject: Re: [PATCH net-next] batman-adv: Fix the wrong definition
References: <20211028072306.1351-1-yajun.deng@linux.dev>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <da6fa493-0911-ca3f-16c0-380bc35d8317@unstable.cc>
Date: Thu, 28 Oct 2021 09:35:28 +0200
MIME-Version: 1.0
In-Reply-To: <20211028072306.1351-1-yajun.deng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Yajun Deng <yajun.deng@linux.dev>, mareklindner@neomailbox.ch, sw@simonwunderlich.de, sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 28/10/2021 09:23, Yajun Deng wrote:
> There are three variables that are required at most,
> no need to define four variables.
> 
> Fixes: 0fa4c30d710d ("batman-adv: Make sysfs support optional")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

NAK.

kobject_uevent_env() does not know how many items are stored in the
array and thus requires it to be NULL terminated.

Please check the following for reference:

https://elixir.bootlin.com/linux/v5.15-rc6/source/lib/kobject_uevent.c#L548

OTOH I guess we could still use '{}' for the initialization.

Regards,

-- 
Antonio Quartulli
