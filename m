Return-Path: <longman@redhat.com>
Subject: Re: WARNING in kernfs_create_dir_ns
References: <000000000000ba8e5605a35d4465@google.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <894635f4-772e-a28c-1078-be8a5093e351@redhat.com>
Date: Wed, 15 Apr 2020 20:30:09 -0400
MIME-Version: 1.0
In-Reply-To: <000000000000ba8e5605a35d4465@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: syzbot <syzbot+38f5d5cf7ae88c46b11a@syzkaller.appspotmail.com>, a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org, davem@davemloft.net, gregkh@linuxfoundation.org, hdanton@sina.com, hongjiefang@asrmicro.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, mareklindner@neomailbox.ch, mingo@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com, tj@kernel.org, ulf.hansson@linaro.org

#syz fix: locking/lockdep: Reuse freed chain_hlocks entries

