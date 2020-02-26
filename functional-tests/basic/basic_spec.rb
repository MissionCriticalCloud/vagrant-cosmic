describe 'Basic Network' do
  it 'starts a Linux VM' do
    expect(`vagrant up`).to include(
      'Network name or id will be ignored',
      'Machine is booted and ready for use!'
    )
    expect($?.exitstatus).to eq(0)
  end
  it 'destroys a Linux VM' do
    expect(`vagrant destroy --force`).to include(
      'Terminating the instance...'
    )
    expect($?.exitstatus).to eq(0)
  end
end
