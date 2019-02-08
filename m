Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 08 Feb 2019 18:26:15 +0100
Message-ID: <9234699.e23Wg4karr@sven-desktop>
In-Reply-To: <041301d4bfc7$2ccff3d0$866fdb70$@telegrid.com>
References: <015501d4be3c$d64ad290$82e077b0$@telegrid.com>
 <6030797.OfDuFm2WhJ@prime> <041301d4bfc7$2ccff3d0$866fdb70$@telegrid.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: Re: [B.A.T.M.A.N.] Alfred problem reading other nodes
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: beth.flippo@telegrid.com
Cc: 'Simon Wunderlich' <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org, s.pinsky@telegrid.com

On Friday, 8 February 2019 16.58.46 CET beth.flippo@telegrid.com wrote:
[...]
> Unicast does not produce any errors at the sendto function and looks like it
> is working but tcpdump doesn't see it and nothing gets to the receive side.
> Tcpdump does see the multicast announcement packets.

You could try to use perf to figure out where the packet might have been lost. 
Here here for example some output when I use 
`ip6tables -t filter -P OUTPUT DROP` and then try to ping something via:

    sudo perf ftrace ping -6 google.de > test

Of course, it doesn't give you a direct answer but you can at least try to 
make an educated guess by searching for the position when the skb is freed:

    34843  3)               |                ip6_send_skb() {
    34844  3)               |                  ip6_local_out() {
    34845  3)               |                    __ip6_local_out() {
    34846  3)               |                      nf_hook_slow() {
    34847  3)               |                        nft_do_chain_ipv6 [nf_tables]() {
    34848  3)   0.146 us    |                          ipv6_find_hdr();
    34849  3)   0.602 us    |                          nft_do_chain [nf_tables]();
    34850  3)   1.259 us    |                        }
    34851  3)               |                        kfree_skb() {
    34852  3)               |                          skb_release_all() {
    34853  3)               |                            skb_release_head_state() {
    34854  3)   0.105 us    |                              dst_release();
    34855  3)               |                              sock_wfree() {
    34856  3)   0.271 us    |                                sock_def_write_space();
    34857  3)   0.505 us    |                              }
    34858  3)   1.072 us    |                            }
    34859  3)               |                            skb_release_data() {
    34860  3)               |                              skb_free_head() {
    34861  3)   0.103 us    |                                kfree();
    34862  3)   0.294 us    |                              }
    34863  3)   0.533 us    |                            }
    34864  3)   2.016 us    |                          }
    34865  3)               |                          kfree_skbmem() {
    34866  3)   0.150 us    |                            kmem_cache_free();
    34867  3)   0.333 us    |                          }
    34868  3)   2.629 us    |                        }
    34869  3)   4.498 us    |                      }
    34870  3)   4.781 us    |                    }
    34871  3)   4.968 us    |                  }
    34872  3)   5.168 us    |                }
    34873  3)   7.532 us    |              }

And without this filter, the function continues and at the end it is queued up 
in the ethernet HW and at some point really given to the ethernet driver
(e1000_xmit_frame).

     7)               |                ip6_send_skb() {
     7)               |                  ip6_local_out() {
     7)               |                    __ip6_local_out() {
     7)               |                      nf_hook_slow() {
     7)               |                        nft_do_chain_ipv6 [nf_tables]() {
     7)   0.221 us    |                          ipv6_find_hdr();
     7)   0.529 us    |                          nft_do_chain [nf_tables]();
     7)   1.405 us    |                        }
     7)   1.966 us    |                      }
     7)   2.354 us    |                    }
     7)               |                    ip6_output() {
     7)               |                      ip6_finish_output() {
     7)   0.785 us    |                        __cgroup_bpf_run_filter_skb();
     7)   0.581 us    |                        ip6_mtu();
     7)               |                        ip6_finish_output2() {
     7)               |                          neigh_resolve_output() {
     7)               |                            eth_header() {
     7)   0.538 us    |                              skb_push();
     7)   1.858 us    |                            }
     7)               |                            dev_queue_xmit() {
     7)               |                              __dev_queue_xmit() {
     7)   0.541 us    |                                dst_release();
     7)   0.903 us    |                                netdev_pick_tx();
     7)               |                                pfifo_fast_enqueue() {
     7)   0.585 us    |                                  _raw_spin_lock();
     7)   1.892 us    |                                }
     7)   0.583 us    |                                _raw_spin_trylock();
     7)               |                                __qdisc_run() {
     7)   1.029 us    |                                  pfifo_fast_dequeue();
     7)   0.858 us    |                                  pfifo_fast_dequeue();
     7)               |                                  sch_direct_xmit() {
     7)               |                                    validate_xmit_skb_list() {
     7)               |                                      validate_xmit_skb() {
     7)               |                                        netif_skb_features() {
     7)   0.537 us    |                                          passthru_features_check();
     7)   0.518 us    |                                          skb_network_protocol();
     7)   2.956 us    |                                        }
     7)   0.579 us    |                                        validate_xmit_xfrm();
     7)   5.413 us    |                                      }
     7)   6.473 us    |                                    }
     7)   0.434 us    |                                    _raw_spin_lock();
     7)               |                                    dev_hard_start_xmit() {
     7)               |                                      dev_queue_xmit_nit() {
     7)               |                                        skb_clone() {
     7)               |                                          kmem_cache_alloc() {
     7)   0.563 us    |                                            should_failslab();
     7)   0.540 us    |                                            memcg_kmem_put_cache();
     7)   2.755 us    |                                          }
     7)               |                                          __skb_clone() {
     7)   0.681 us    |                                            __copy_skb_header();
     7)   1.915 us    |                                          }
     7)   6.311 us    |                                        }
     7)   0.721 us    |                                        ktime_get_with_offset();
     7)               |                                        packet_rcv() {
     7)   1.027 us    |                                          skb_push();
     7)               |                                          __bpf_prog_run32() {
     7)   2.280 us    |                                            ___bpf_prog_run();
     7)   3.418 us    |                                          }
     7)               |                                          consume_skb() {
     7)               |                                            skb_release_all() {
     7)   0.668 us    |                                              skb_release_head_state();
     7)   0.615 us    |                                              skb_release_data();
     7)   2.927 us    |                                            }
     7)               |                                            kfree_skbmem() {
     7)   0.712 us    |                                              kmem_cache_free();
     7)   1.705 us    |                                            }
     7)   6.126 us    |                                          }
     7) + 13.655 us   |                                        }
     7) + 23.417 us   |                                      }
     7)               |                                      e1000_xmit_frame [e1000e]() {
     7)   0.723 us    |                                        e1000_maybe_stop_tx [e1000e]();
     7)   0.711 us    |                                        swiotlb_map_page();
     7)   0.542 us    |                                        swiotlb_dma_mapping_error();
     7)   0.444 us    |                                        e1000_maybe_stop_tx [e1000e]();
     7)   6.934 us    |                                      }
     7) + 32.409 us   |                                    }
     7) + 41.556 us   |                                  }
     7)   0.572 us    |                                  pfifo_fast_dequeue();
     7) + 47.066 us   |                                }
     7)   0.574 us    |                                __local_bh_enable_ip();
     7) + 56.331 us   |                              }
     7) + 57.439 us   |                            }
     7) + 61.122 us   |                          }
     7)   0.588 us    |                          __local_bh_enable_ip();
     7) + 63.722 us   |                        }


You can also see this successful transmit in the net tracepoints:

    sudo perf trace --syscalls -e 'net:*' -e 'skb:*'  ping google.de
    [...]
      7013.921 (         ): ping/18832 sendto(fd: 4<socket:[266397]>, buff: 0x558076ff39c0, len: 64, flags: CONFIRM, addr: 0x558076ff1940, addr_len: 28) ...
      7013.962 (         ): net:net_dev_queue:dev=enp0s31f6 skbaddr=0xffff94a2328e2e00 len=118
      7013.981 (         ): skb:consume_skb:skbaddr=0xffff94a2328e3f00
      7013.994 (         ): net:net_dev_start_xmit:dev=enp0s31f6 queue_mapping=0 skbaddr=0xffff94a2328e2e00 vlan_tagged=0 vlan_proto=0x0000 vlan_tci=0x0000 protocol=0x86dd ip_summed=0 len=118 data_len=0 network_offset=14 transport_offset_valid=1 transport_offset=54 tx_flags=0 gso_size=0 gso_segs=0 gso_type=0
      7014.006 (         ): net:net_dev_xmit:dev=enp0s31f6 skbaddr=0xffff94a2328e2e00 len=118 rc=0
      7013.921 ( 0.094 ms): ping/18832  ... [continued]: sendto()) = 64
    64 bytes from prg03s06-in-x03.1e100.net (2a00:1450:4014:80d::2003): icmp_seq=8 ttl=55 time=42.5 ms
      7014.024 (         ): ping/18832 recvmsg(fd: 4<socket:[266397]>, msg: 0x7ffcc8a9d000                   ) ...
      7056.519 (         ): skb:skb_copy_datagram_iovec:skbaddr=0xffff94a208eeac00 len=64
      7056.525 (         ): skb:consume_skb:skbaddr=0xffff94a208eeac00
      7014.024 (42.504 ms): ping/18832  ... [continued]: recvmsg()) = 64

For the filtered testcase you can see the kfree_skb:

    9221.434 (         ): ping/18913 sendto(fd: 4<socket:[259911]>, buff: 0x5561881769c0, len: 64, addr: 0x556188174940, addr_len: 28) ...
    9221.473 (         ): skb:kfree_skb:skbaddr=0xffff94a2382df600 protocol=34525 location=0xffffffff9701a307

Kind regards,
	Sven


