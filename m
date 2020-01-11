Return-Path: <xiyou.wangcong@gmail.com>
MIME-Version: 1.0
References: <000000000000a06985059be4002e@google.com>
In-Reply-To: <000000000000a06985059be4002e@google.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 11 Jan 2020 15:38:19 -0800
Message-ID: <CAM_iQpWN-SKjjrG_7EQ-x+7UMiu6foaNWMJuwQuwN0BGmayB+A@mail.gmail.com>
Subject: Re: WARNING: bad unlock balance in __dev_queue_xmit
Content-Type: text/plain; charset="UTF-8"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+ad4ea1dd5d26131a58a6@syzkaller.appspotmail.com>
Cc: a@unstable.cc, Alexander Aring <alex.aring@gmail.com>, allison@lohutok.net, andrew@lunn.ch, Andy Gospodarek <andy@greyhouse.net>, Taehee Yoo <ap420073@gmail.com>, ast@domdv.de, b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux-foundation.org, cleech@redhat.com, Daniel Borkmann <daniel@iogearbox.net>, David Miller <davem@davemloft.net>, David Ahern <dsa@cumulusnetworks.com>, Florian Fainelli <f.fainelli@gmail.com>, Florian Westphal <fw@strlen.de>, Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com, haiyangz@microsoft.com, info@metux.net, Jay Vosburgh <j.vosburgh@gmail.com>, j@w1.fi, Jakub Kicinski <jakub.kicinski@netronome.com>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Johan Hedberg <johan.hedberg@gmail.com>, Johannes Berg <johannes.berg@intel.com>, John Hurley <john.hurley@netronome.com>, jwi@linux.ibm.com, Kate Stewart <kstewart@linuxfoundation.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Kalle Valo <kvalo@codeaurora.org>, kys@microsoft.com, linmiaohe@huawei.com, linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-hams <linux-hams@vger.kernel.org>, linux-hyperv@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-ppp@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>, linux-wpan@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Marek Lindner <mareklindner@neomailbox.ch>, Michal Kubecek <mkubecek@suse.cz>, mmanning@vyatta.att-mail.com, Linux Kernel Network Developers <netdev@vger.kernel.org>, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, oss-drivers@netronome.com, Paolo Abeni <pabeni@redhat.com>, Paul Mackerras <paulus@samba.org>

#syz dup: WARNING: bad unlock balance in sch_direct_xmit
