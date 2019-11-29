Return-Path: <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: general protection fault in smack_socket_sendmsg (2)
References: <000000000000723a32059870fbd4@google.com>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <ee964c66-da56-def6-9525-6d960ab9487a@I-love.SAKURA.ne.jp>
Date: Fri, 29 Nov 2019 18:39:49 +0900
MIME-Version: 1.0
In-Reply-To: <000000000000723a32059870fbd4@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+131d2229316b7012ac06@syzkaller.appspotmail.com>, syzkaller-bugs@googlegroups.com
Cc: b.a.t.m.a.n@lists.open-mesh.org, jmorris@namei.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, netdev@vger.kernel.org, serge@hallyn.com, Casey Schaufler <casey@schaufler-ca.com>

On 2019/11/29 9:05, syzbot wrote:
>  rxrpc_send_keepalive+0x254/0x3c0 net/rxrpc/output.c:655

Again net/rxrpc/output.c:655

#syz dup: KMSAN: use-after-free in rxrpc_send_keepalive
